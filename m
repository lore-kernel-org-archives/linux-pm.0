From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH 0/2] swsusp: improve freeing of
	memory
Date: Wed, 9 Nov 2005 01:32:21 +0100
Message-ID: <20051109003221.GA22540@elf.ucw.cz>
References: <200511082355.43984.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============31591115623486155=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200511082355.43984.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============31591115623486155==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> The following two patches are designed to make swsusp free only as much
> memory as needed for suspend and not as much as possible.  This speeds
> up the suspend and resume significantly and causes the system to be much
> more responsive after resume.

Yep, users will love you :-). But you need to let them know, and that
probably means cc: on linux-kernel.

If you want someone to test crypto swsusp, ask ast@domdv.de. But
removing that option is okay, too.

I still miss those "a"s in "swap".

+
+unsigned int snapshot_nr_pages(void)
+{
+       return nr_copy_pages;
+}
+
+struct pbe *snapshot_pblist(void)
+{
+       return pagedir_nosave;
+}
+
+void snapshot_pblist_set(struct pbe *pblist)
+{
+       pagedir_nosave = pblist;
+}

I really hate these. pblist_set( is the worst one. [Still improvement
from previous versions, through.] Perhaps you can just access the
variables directly?

If you really want to clean this up, swsusp_save should probably be 

int swsusp_save(struct pbe **pblist, int *nr_pages)

[that should make snapshot_nr_pages and snapshot_pblist obsolete,
right?] 

Getting rid of snapshot_pblist_set may require a bit more surgery, but
should be doable, too. swsusp_resume() should probably get struct pbe *argument...

								Pavel
-- 
Thanks, Sharp!

--===============31591115623486155==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============31591115623486155==--
