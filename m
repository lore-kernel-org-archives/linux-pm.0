From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 44/70] cpufreq: interactive: fix crash on error paths in get_tokenized_data
Date: Tue, 27 Oct 2015 18:30:32 +0100
Message-ID: <1445967059-6897-44-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Todd Poynor <toddpoynor@google.com>

Use separate variable for error code, free proper pointer.

Change-Id: Ia83cccb195997789ac6afbf5b8761f7b278196d6
Reported-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 7c734fa..3dc067e 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -647,29 +647,26 @@ static unsigned int *get_tokenized_data(const cha=
r *buf, int *num_tokens)
 	int i;
 	int ntokens =3D 1;
 	unsigned int *tokenized_data;
+	int err =3D -EINVAL;
=20
 	cp =3D buf;
 	while ((cp =3D strpbrk(cp + 1, " :")))
 		ntokens++;
=20
-	if (!(ntokens & 0x1)) {
-		tokenized_data =3D ERR_PTR(-EINVAL);
+	if (!(ntokens & 0x1))
 		goto err;
-	}
=20
 	tokenized_data =3D kmalloc(ntokens * sizeof(unsigned int), GFP_KERNEL=
);
 	if (!tokenized_data) {
-		tokenized_data =3D ERR_PTR(-ENOMEM);
+		err =3D -ENOMEM;
 		goto err;
 	}
=20
 	cp =3D buf;
 	i =3D 0;
 	while (i < ntokens) {
-		if (sscanf(cp, "%u", &tokenized_data[i++]) !=3D 1) {
-			tokenized_data =3D ERR_PTR(-EINVAL);
+		if (sscanf(cp, "%u", &tokenized_data[i++]) !=3D 1)
 			goto err_kfree;
-		}
=20
 		cp =3D strpbrk(cp, " :");
 		if (!cp)
@@ -677,10 +674,8 @@ static unsigned int *get_tokenized_data(const char=
 *buf, int *num_tokens)
 		cp++;
 	}
=20
-	if (i !=3D ntokens) {
-		tokenized_data =3D ERR_PTR(-EINVAL);
+	if (i !=3D ntokens)
 		goto err_kfree;
-	}
=20
 	*num_tokens =3D ntokens;
 	return tokenized_data;
@@ -688,7 +683,7 @@ static unsigned int *get_tokenized_data(const char =
*buf, int *num_tokens)
 err_kfree:
 	kfree(tokenized_data);
 err:
-	return tokenized_data;
+	return ERR_PTR(err);
 }
=20
 static ssize_t show_target_loads(
--=20
1.7.9.5
