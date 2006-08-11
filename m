From: david singleton <dsingleton@mvista.com>
Subject: Re: PowerOp core patch
Date: Thu, 10 Aug 2006 19:38:27 -0700
Message-ID: <1d4c6c3d497ffd877c4039960211c3bd@mvista.com>
References: <44D8D45F.80209@mvista.com>
	<Pine.LNX.4.60.0608102041510.6141@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.60.0608102041510.6141@poirot.grange>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


On Aug 10, 2006, at 11:43 AM, Guennadi Liakhovetski wrote:

> On Tue, 8 Aug 2006, David Singleton wrote:
>
>> Here is the core patch for the PowerOp concept.  It adds the powerop
>> struct
>> for opertaing point support to linux/pm.h and adds support to =

>> transition
>> to supported operating points by
>> setting their name into /sys/power/state.
>
> Sorry, a stupid question - reboot, halt / poweroff (always wanted to =

> know
> the difference...) are not power states, right?...

Correct.  Power states are states in which the system can operate.
Halt gets the system ready to turn power off,  reboot just brings the =

system
down and then boots it up again.

>
>> The supported operating points are shown in a readonly sysfs file,
>> /sys/power/supported_states.
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
