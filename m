From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
Date: Mon, 30 Oct 2006 15:56:26 +0200
Message-ID: <20061030135625.GB1601@mellanox.co.il>
References: <20061029231358.GI27968@stusta.de>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061029231358.GI27968@stusta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com, Linus Torvalds <torvalds@osdl.org>, linux-pm@osdl.org, linux-acpi@vger.kernel.org, Jun'ichi Nomura <j-nomura@ce.jp.nec.com>, Martin Lorenz <martin@lorenz.eu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

Quoting r. Adrian Bunk <bunk@stusta.de>:
> Subject    : T60 stops triggering any ACPI events
> References : http://lkml.org/lkml/2006/10/4/425
>              http://lkml.org/lkml/2006/10/16/262
>              http://bugzilla.kernel.org/show_bug.cgi?id=3D7408
> Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
> Status     : unknown

OK, I spent half a night with git-bisect, and the patch that triggers this =
issue
seems to be this:

commit d7dd8fd9557840162b724a8ac1366dd78a12dff
Author: Andrew Morton <akpm@osdl.org> =

    [PATCH] blockdev.c: check driver layer errors

Reset to d7dd8fd9557840162b724a8ac1366dd78a12dff seems to hide part of the =
issue
(I have ACPI after kernel build, but not after suspend/resume).  Both rever=
ting
this patch, and reset to the parent of this patch seem to solve (or at leas=
t,
hide) both problems for me (no ACPI after suspend/resume and no ACPI after
kernel build).

I am currently running on 2.6.19-rc3 minus
d7dd8fd9557840162b724a8ac1366dd78a12dff, and in a full day of use I have not
observed any issues yet. 2.6.19-rc3 without reverting
d7dd8fd9557840162b724a8ac1366dd78a12dff stops receiving ACPI events after s=
ome
use (sometimes after suspend/resume, sometimes after kernel build stress). =
 Now,
what does this tell us? Andrew, any idea?


Martin, could you test whether reverting this helps you, too, by chance?
Here's a patch to apply for testing this.

---

commit 658488b7577b7b2242372c43f081f55e2d274615
Author: Michael S. Tsirkin <mst@mellanox.co.il>
Date:   Mon Oct 30 01:28:40 2006 +0200

    Revert "[PATCH] blockdev.c: check driver layer errors"
    =

    This reverts commit 4d7dd8fd9557840162b724a8ac1366dd78a12dff.

diff --git a/fs/block_dev.c b/fs/block_dev.c
index bc8f27c..b15ad29 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -545,11 +545,11 @@ static struct kobject *bdev_get_holder(s
 		return kobject_get(bdev->bd_disk->holder_dir);
 }
 =

-static int add_symlink(struct kobject *from, struct kobject *to)
+static void add_symlink(struct kobject *from, struct kobject *to)
 {
 	if (!from || !to)
-		return 0;
-	return sysfs_create_link(from, to, kobject_name(to));
+		return;
+	sysfs_create_link(from, to, kobject_name(to));
 }
 =

 static void del_symlink(struct kobject *from, struct kobject *to)
@@ -650,38 +650,30 @@ static void free_bd_holder(struct bd_hol
  * If there is no matching entry with @bo in @bdev->bd_holder_list,
  * add @bo to the list, create symlinks.
  *
- * Returns 0 if symlinks are created or already there.
- * Returns -ve if something fails and @bo can be freed.
+ * Returns 1 if @bo was added to the list.
+ * Returns 0 if @bo wasn't used by any reason and should be freed.
  */
 static int add_bd_holder(struct block_device *bdev, struct bd_holder *bo)
 {
 	struct bd_holder *tmp;
-	int ret;
 =

 	if (!bo)
-		return -EINVAL;
+		return 0;
 =

 	list_for_each_entry(tmp, &bdev->bd_holder_list, list) {
 		if (tmp->sdir =3D=3D bo->sdir) {
 			tmp->count++;
-			/* We've already done what we need to do here. */
-			free_bd_holder(bo);
 			return 0;
 		}
 	}
 =

 	if (!bd_holder_grab_dirs(bdev, bo))
-		return -EBUSY;
+		return 0;
 =

-	ret =3D add_symlink(bo->sdir, bo->sdev);
-	if (ret =3D=3D 0) {
-		ret =3D add_symlink(bo->hdir, bo->hdev);
-		if (ret)
-			del_symlink(bo->sdir, bo->sdev);
-	}
-	if (ret =3D=3D 0)
-		list_add_tail(&bo->list, &bdev->bd_holder_list);
-	return ret;
+	add_symlink(bo->sdir, bo->sdev);
+	add_symlink(bo->hdir, bo->hdev);
+	list_add_tail(&bo->list, &bdev->bd_holder_list);
+	return 1;
 }
 =

 /**
@@ -751,9 +743,7 @@ static int bd_claim_by_kobject(struct bl
 =

 	mutex_lock_nested(&bdev->bd_mutex, BD_MUTEX_PARTITION);
 	res =3D bd_claim(bdev, holder);
-	if (res =3D=3D 0)
-		res =3D add_bd_holder(bdev, bo);
-	if (res)
+	if (res || !add_bd_holder(bdev, bo))
 		free_bd_holder(bo);
 	mutex_unlock(&bdev->bd_mutex);
 =



-- =

MST
