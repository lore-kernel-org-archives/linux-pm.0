From: Dave Airlie <airlied@gmail.com>
Subject: Re: Resume problem with radeon+KMS (2.6.34-rc2 and
	before)
Date: Mon, 22 Mar 2010 09:10:24 +1000
Message-ID: <21d7e9971003211610h268e10e8oc9ecf06390e421b9__35991.9468210593$1269213085$gmane$org@mail.gmail.com>
References: <201003212228.13923.rjw@sisk.pl>
	<21d7e9971003211536p78792320rf93f9ba5db6c54ff@mail.gmail.com>
	<201003220007.44981.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003220007.44981.rjw@sisk.pl>
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
Cc: =?ISO-8859-1?Q?J=E9r=F4me_Glisse?= <glisse@freedesktop.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 22, 2010 at 9:07 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Sunday 21 March 2010, Dave Airlie wrote:
>> 2010/3/22 Rafael J. Wysocki <rjw@sisk.pl>:
>> > Hi,
>> >
>> > Some time ago I reported a problem with resuming from suspend to RAM on
>> > HP nx6325 with radeon+KMS.
>>
>> Can you post the X.org log file? if you are really using 6.12.4 and
>> not a backport
>> then the userspace driver has no KMS support and it is trashing the system.
>
> Appended below.
>

So your userspace is incompatible with KMS, so I'd suggest trying to
get 6.12.191
or -ati git master,

Dave.
