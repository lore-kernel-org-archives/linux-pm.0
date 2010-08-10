From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM QoS dynamic resource manager
Date: Tue, 10 Aug 2010 09:24:57 -0700
Message-ID: <AANLkTi=s3fowR=qd_tm61Tgxq2XBStbCK8-erpDiZ+ay@mail.gmail.com>
References: <alpine.DEB.2.00.1005211533530.25765@pchidamb-lnx.qualcomm.com>
	<20100525145223.GA4974@gvim.org>
	<AANLkTikLgu2c1GPE3glHLlaznOM59SVeCj2NHzDjyjZR@mail.gmail.com>
	<20100608033333.GA23066@gvim.org>
	<AANLkTinGBvZm870CsjocsCV1SmQ-FCCbJLtKWR1juB1Q@mail.gmail.com>
	<4C0ECC38.2000003@codeaurora.org> <20100609030525.GD26668@gvim.org>
	<1276265566.8214.2.camel@localhost>
	<87zkytffyg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87zkytffyg.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: mark gross <640e9920@gmail.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 17, 2010 at 3:32 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Kevin Hilman <khilman@deeprootsystems.com> writes:
>
>> On Tue, 2010-06-08 at 20:05 -0700, mark gross wrote:
>>> On Tue, Jun 08, 2010 at 04:03:20PM -0700, Bryan Huntsman wrote:
>>> >
>>> > Mike, one idea I'm exploring is having platform-specific busses with
>>> > QoS constraints specified via runtime_pm as part of the LDM. =A0Adding
>>> > dynamic class creation within pm_qos, or a type enum as you suggest,
>>> > would work. =A0However, I think this kind of behavior would fit nicely
>>> > within runtime_pm.
>>> >
>>>
>>> Something like that is what Kevin Hilman was thinking too. =A0It would
>>> bring a qos concept to the LDM for each bus driver object.
>>

[...]

> It would be great if we could all get together at one of the
> conferences this year to talk through some of our ideas in more
> detail. =A0I plan to be at ELC Europe (October in UK) and Linux Plumbers
> (Nov in Boston) with a remote possibility of making it to LinuxCon
> (Aug in Boston, which includes a PM mini-summit on Monday.)

FYI... I've added a proposal to the PM mini-conf at Plumbers to have
more detailed discussion on per-device constraints:

   http://www.linuxplumbersconf.org/2010/ocw/events/LPC2010MC/proposals

Kevin
