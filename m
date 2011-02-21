From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.37.1 s2disk regression (TPM)
Date: Mon, 21 Feb 2011 23:17:07 +0100
Message-ID: <201102212317.07295.rjw__41829.7311677181$1298328452$gmane$org@sisk.pl>
References: <4D60E93D.1050205@gmail.com> <4D62E221.7010104@linux.vnet.ibm.com>
	<4D62E2F2.4060406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D62E2F2.4060406@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Rajiv Andrade <srajiv@linux.vnet.ibm.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, debora@linux.vnet.ibm.com, preining@logic.at, linux-pm <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, February 21, 2011, Jiri Slaby wrote:
> On 02/21/2011 11:07 PM, Rajiv Andrade wrote:
> > On 02/21/2011 06:44 PM, Jiri Slaby wrote:
> >> On 02/21/2011 10:29 PM, Stefan Berger wrote:
> >>> On 02/21/2011 03:39 PM, Jiri Slaby wrote:
> >>>> On 02/21/2011 06:12 PM, Rajiv Andrade wrote:
> >>>>> On 02/21/2011 01:34 PM, Jiri Slaby wrote:
> >>>>>> There has to be another problem which caused my regression. And
> >>>>>> since it
> >>>>>> reports "Operation Timed out", the former default timeout values
> >>>>>> worked
> >>>>>> for me, the ones read from TPM do not.
> >>>>> Yes, it's highly due inconsistent timeout values reported by the
> >>>>> TPM as
> >>>>> I mentioned, my working timeouts are:
> >>>>> 3020000 4510000 181000000
> >>>> 1000000 2000 150000
> >>>>
> >>>> Actually the first one from HW is 1. This is one is HZ after correction
> >>>> in get_timeout. So perhaps it is in ms, yes.
> >>> Following the specs, the timeouts are supposed to be in microseconds and
> >>> ascending order for short, medium and long duration. Of course, if the
> >>> device returns wrong timeouts, the command isn't going to succeed,
> >>> failing the suspend in this case. Nevertheless, I think we need the
> >>> patch I put in but at the same time we'll need a work-around for devices
> >>> like this.
> >> Yes, the patch is correct per se. But as it breaks bunch of machines it
> >> cannot go in now. The rule is no regressions.
> >>
> >> After you have the workaround it should go into the next rc1 after that.
> >> Do you plan to add a dmi-based quirk? Or, IOW do you want me to attach
> >> dmidecode output? Or are you going to base it solely on TPM
> >> manufacturer/version
> > It's more reliable to base the workaround on the values themselves,
> > instead of the TPM's ID, since
> > we don't know whether other models will behave similarly.
> 
> As I wrote, you may base it on dmi data.

In which case this report will have to be taken into account too:
http://marc.info/?l=linux-acpi&m=129796038509311&w=4

Thanks,
Rafael
