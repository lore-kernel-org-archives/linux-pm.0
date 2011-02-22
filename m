From: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Subject: Re: [Xen-devel] [PATCH 2/3] xen: use freeze/restore/thaw
 PM events for suspend/resume/chkpt
Date: Tue, 22 Feb 2011 14:53:32 -0800
Message-ID: <AANLkTin-59FV2N6=oToridqdj8nAGgVQQURvczsGvp09__40645.7996731207$1298415390$gmane$org@mail.gmail.com>
References: <1298157158-5421-1-git-send-email-rshriram@cs.ubc.ca>
	<1298157158-5421-3-git-send-email-rshriram@cs.ubc.ca>
	<20110222204320.GB4605@dumpdata.com>
	<AANLkTikrUUG92vQS_ZkdKCZ_+1BahQfAhRB-=8eNNW2o@mail.gmail.com>
	<20110222223638.GA1341@dumpdata.com>
Reply-To: rshriram@cs.ubc.ca
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110222223638.GA1341@dumpdata.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com, Iam Campbell <ian.campbell@citrix.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 22, 2011 at 2:36 PM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>> > Could we just make CONFIG_XEN_SAVE_RESTORE depend on CONFIG_HIBERANTIO=
N?
>> > Like this:
>> >
>> >
>> > diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
>> > index 5b54892..838e20c 100644
>> > --- a/arch/x86/xen/Kconfig
>> > +++ b/arch/x86/xen/Kconfig
>> > @@ -38,7 +38,7 @@ config XEN_MAX_DOMAIN_MEMORY
>> >
>> > =A0config XEN_SAVE_RESTORE
>> > =A0 =A0 =A0 =A0bool
>> > - =A0 =A0 =A0 depends on XEN && PM
>> > + =A0 =A0 =A0 depends on XEN && PM && HIBERNATION
>> > =A0 =A0 =A0 =A0default y
>> >
>> > =A0config XEN_DEBUG_FS
>> >
>> >
>> On that aspect, just noticed
>> config PM_SLEEP
>> =A0 =A0 =A0 =A0 bool
>> =A0 =A0 =A0 =A0 depends on SUSPEND || HIBERNATION || XEN_SAVE_RESTORE
>> =A0 =A0 =A0 =A0 default y
>> we could get rid of XEN_SAVE_RESTORE as the suspend/resume code doesnt
>> depend on PM_SLEEP
>
> OK. Do you want to respin patch #2 without the #ifdefs in the drivers/bas=
e/...
> and provide a new patch (#4?) which will alter the Kconfig file appropria=
tely?
>
>
yep. will do.
shriram
