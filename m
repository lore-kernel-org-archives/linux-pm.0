From: Matthew Locke <matthew.a.locke@comcast.net>
Subject: Re: nokia 770 [was Re: community PM requirements/issues
	and PowerOP]
Date: Wed, 13 Dec 2006 13:27:35 -0800
Message-ID: <95FB331B-DBAC-4DF9-8F2D-4EBB0FF24635@comcast.net>
References: <20060914101704.GA17820@elf.ucw.cz>
	<1158583334.28629.19.camel@localhost>
	<20060919182523.GE7099@elf.ucw.cz>
	<200612121200.18513.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200612121200.18513.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: scott.preece@motorola.com, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>, Amit Kucheria <amit.kucheria@nokia.com>
List-Id: linux-pm@vger.kernel.org


On Dec 12, 2006, at 12:00 PM, David Brownell wrote:

> On Tuesday 19 September 2006 11:25 am, Pavel Machek wrote:
>>
>> Could you perhaps provide list of operating points for 770? It would
>> help understanding a bit, I'd say.
>
> If there was a followup here, I missed it ...

I think there was some sort of followup but I don't think it  =

explictly listed the operating point values.
>
> ISTR that it doesn't use (formal) operating points, and that a lot  =

> of the
> basic SOC power savings (vs powering off the display or wifi) come  =

> from a
> different kind of mechanism entirely.  Namely, a combination of  =

> dynamic
> tick with a modified system idle task, which enters one of the OMAP  =

> low
> power modes during those long periods between clock ticks or other  =

> irqs.
>
> That's one of the standard power saving schemes used on OMAP1  =

> platforms
> with Linux.

Well sure but I think this discussion was about using the 770 as a  =

specific example of operating point values.  Here are the operating  =

points used on omap1.  The board specific part is just whether or not  =

the board has a scalable voltage regulator.  Omap1 has a fairly  =

simple operating point definition and is, of course, not the latest h/w.

This table comes from the DPM implementation on OMAP1 and is  =

expressed as dividers.

Name	Voltage, DPLL multiplier, DPLL divider, cpu divider, tc divider  =

(mem bus).

  192        	1300 16 1 1  2
  168        	1300 14 1 1  2
  84			1300 14 1 2  2
  84-1.1v   	1050 14 1 2  2
  60         		1300  5 1 1  1
  60-1.1v    	1050  5 1 1  1
  sleep-168  	1300 14 1 0 -1
  sleep-60   	1300  1 2 0  2

Several other parameters could be added such as dsp and dsp mmu if  =

one wanted to do more aggressive power management.  btw, the  =

parameter names I list above are from memory so I might have the  =

order mixed up but you get the idea.

The dpm utilities on sf.net also include 8 example operating points  =

for pxa272.  The operating point definition on pxa has ~5 parameters  =

including voltage, cpu frequency and other clocks.



>
> - Dave
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
