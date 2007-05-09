From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: [RFC][PATCH -mm 1/2] swsusp: Remove platform callbacks
	from restore code
Date: Wed, 9 May 2007 15:59:45 +0400
Message-ID: <8f8ff01d0705090459l346d1118m1b06a2a384c636c0__29281.7798945636$1178730584$gmane$org@mail.gmail.com>
References: <200705052227.14265.rjw@sisk.pl> <200705072257.13405.rjw@sisk.pl>
	<200705090019.20232.rjw@sisk.pl> <200705090027.05735.rjw@sisk.pl>
	<8f8ff01d0705082358t74c08b5dja18e1c8b6c8e53e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_920_21345230.1178711985133"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8f8ff01d0705082358t74c08b5dja18e1c8b6c8e53e8@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, suspend-devel@lists.sourceforge.net, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

------=_Part_920_21345230.1178711985133
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch will disable EC GPE, which seems to be major problem.

Regards,
Alex

On 5/9/07, Alexey Starikovskiy <aystarik@gmail.com> wrote:
> I expect http://bugzilla.kernel.org/show_bug.cgi?id=7887 this bug to
> pop again with this patch.
>
> Regards,
> Alex.
>
> On 5/9/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > The restore part of the hibernation code should not call any 'platform'
> > functions, since it doesn't carry out any power transition of the system.
> > Still, such functions are called from the restore code in kernel/power/user.c .
> > Fix that.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  kernel/power/user.c |   17 ++++-------------
> >  1 file changed, 4 insertions(+), 13 deletions(-)
> >
> > Index: linux-2.6.21/kernel/power/user.c
> > ===================================================================
> > --- linux-2.6.21.orig/kernel/power/user.c       2007-05-08 22:10:36.000000000 +0200
> > +++ linux-2.6.21/kernel/power/user.c    2007-05-08 23:03:17.000000000 +0200
> > @@ -179,34 +179,25 @@ static inline int snapshot_suspend(int p
> >         return error;
> >  }
> >
> > -static inline int snapshot_restore(int platform_suspend)
> > +static inline int snapshot_restore(void)
> >  {
> >         int error;
> >
> >         mutex_lock(&pm_mutex);
> >         pm_prepare_console();
> > -       if (platform_suspend) {
> > -               error = platform_prepare();
> > -               if (error)
> > -                       goto Finish;
> > -       }
> >         suspend_console();
> >         error = device_suspend(PMSG_PRETHAW);
> >         if (error)
> > -               goto Resume_devices;
> > +               goto Finish;
> >
> >         error = disable_nonboot_cpus();
> >         if (!error)
> >                 error = swsusp_resume();
> >
> >         enable_nonboot_cpus();
> > - Resume_devices:
> > -       if (platform_suspend)
> > -               platform_finish();
> > -
> > + Finish:
> >         device_resume();
> >         resume_console();
> > - Finish:
> >         pm_restore_console();
> >         mutex_unlock(&pm_mutex);
> >         return error;
> > @@ -272,7 +263,7 @@ static int snapshot_ioctl(struct inode *
> >                         error = -EPERM;
> >                         break;
> >                 }
> > -               error = snapshot_restore(data->platform_suspend);
> > +               error = snapshot_restore();
> >                 break;
> >
> >         case SNAPSHOT_FREE:
> >
> > _______________________________________________
> > linux-pm mailing list
> > linux-pm@lists.linux-foundation.org
> > https://lists.linux-foundation.org/mailman/listinfo/linux-pm
> >
>

------=_Part_920_21345230.1178711985133
Content-Type: text/x-patch; name="disable_EC_GPE_during_suspend.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="disable_EC_GPE_during_suspend.patch"
X-Attachment-Id: f_f1hqp2dx

RGlzYWJsZSBFQyBHUEUgZHVyaW5nIHN1c3BlbmQvcmVzdW1lCgpGcm9tOiAgPD4KCgotLS0KCiBk
cml2ZXJzL2FjcGkvZWMuYyB8ICAgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KwogMSBmaWxlcyBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9lYy5jIGIvZHJpdmVycy9hY3BpL2VjLmMKaW5kZXggZTA4
Y2Y5OC4uMjNhYzNiYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9hY3BpL2VjLmMKKysrIGIvZHJpdmVy
cy9hY3BpL2VjLmMKQEAgLTc5LDYgKzc5LDggQEAgc3RhdGljIGludCBhY3BpX2VjX3JlbW92ZShz
dHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSwgaW50IHR5cGUpOwogc3RhdGljIGludCBhY3BpX2Vj
X3N0YXJ0KHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlKTsKIHN0YXRpYyBpbnQgYWNwaV9lY19z
dG9wKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlLCBpbnQgdHlwZSk7CiBzdGF0aWMgaW50IGFj
cGlfZWNfYWRkKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlKTsKK3N0YXRpYyBpbnQgYWNwaV9l
Y19zdXNwZW5kKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlLCBwbV9tZXNzYWdlX3Qgc3RhdGUp
Oworc3RhdGljIGludCBhY3BpX2VjX3Jlc3VtZShzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSk7
CiAKIHN0YXRpYyBzdHJ1Y3QgYWNwaV9kcml2ZXIgYWNwaV9lY19kcml2ZXIgPSB7CiAJLm5hbWUg
PSAiZWMiLApAQCAtODksNiArOTEsOCBAQCBzdGF0aWMgc3RydWN0IGFjcGlfZHJpdmVyIGFjcGlf
ZWNfZHJpdmVyID0gewogCQkucmVtb3ZlID0gYWNwaV9lY19yZW1vdmUsCiAJCS5zdGFydCA9IGFj
cGlfZWNfc3RhcnQsCiAJCS5zdG9wID0gYWNwaV9lY19zdG9wLAorCQkuc3VzcGVuZCA9IGFjcGlf
ZWNfc3VzcGVuZCwKKwkJLnJlc3VtZSA9IGFjcGlfZWNfcmVzdW1lLAogCQl9LAogfTsKIApAQCAt
NzcyLDYgKzc3NiwzNiBAQCBzdGF0aWMgaW50IGFjcGlfZWNfc3RvcChzdHJ1Y3QgYWNwaV9kZXZp
Y2UgKmRldmljZSwgaW50IHR5cGUpCiAJcmV0dXJuIDA7CiB9CiAKK3N0YXRpYyBpbnQgYWNwaV9l
Y19zdXNwZW5kKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlLCBwbV9tZXNzYWdlX3Qgc3RhdGUp
Cit7CisJc3RydWN0IGFjcGlfZWMgKmVjOworCisJaWYgKCFkZXZpY2UpCisJCXJldHVybiAtRUlO
VkFMOworCisJZWMgPSBhY3BpX2RyaXZlcl9kYXRhKGRldmljZSk7CisJaWYgKCFlYykKKwkJcmV0
dXJuIC1FSU5WQUw7CisJYWNwaV9kaXNhYmxlX2dwZShOVUxMLCBlYy0+Z3BlLCBBQ1BJX05PVF9J
U1IpOworCisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgYWNwaV9lY19yZXN1bWUoc3RydWN0
IGFjcGlfZGV2aWNlICpkZXZpY2UpCit7CisJc3RydWN0IGFjcGlfZWMgKmVjOworCisJaWYgKCFk
ZXZpY2UpCisJCXJldHVybiAtRUlOVkFMOworCisJZWMgPSBhY3BpX2RyaXZlcl9kYXRhKGRldmlj
ZSk7CisJaWYgKCFlYykKKwkJcmV0dXJuIC1FSU5WQUw7CisJYWNwaV9lbmFibGVfZ3BlKE5VTEws
IGVjLT5ncGUsIEFDUElfTk9UX0lTUik7CisKKwlyZXR1cm4gMDsKK30KKwogc3RhdGljIGFjcGlf
c3RhdHVzCiBlY19wYXJzZV9kZXZpY2UoYWNwaV9oYW5kbGUgaGFuZGxlLCB1MzIgTGV2ZWwsIHZv
aWQgKmNvbnRleHQsIHZvaWQgKipyZXR2YWwpCiB7Cg==
------=_Part_920_21345230.1178711985133
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_920_21345230.1178711985133--
