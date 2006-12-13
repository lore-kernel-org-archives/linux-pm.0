From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: nokia 770 [was Re: community PM requirements/issues
 and PowerOP]
Date: Thu, 14 Dec 2006 00:56:24 +0300
Message-ID: <45807708.3090607@gmail.com>
References: <20060914101704.GA17820@elf.ucw.cz> <457FEE17.8080806@gmail.com>
	<20061213210359.GC11843@elf.ucw.cz>
	<200612131332.58606.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200612131332.58606.david-b@pacbell.net>
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
Cc: linux-pm@lists.osdl.org, matthew.a.locke@comcast.net, scott.preece@motorola.com, Pavel Machek <pavel@ucw.cz>, Amit Kucheria <amit.kucheria@nokia.com>
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:
> On Wednesday 13 December 2006 1:03 pm, Pavel Machek wrote:
>> On Wed 2006-12-13 15:12:07, Eugeny S. Mints wrote:
>>> David Brownell wrote:
>>>> On Tuesday 19 September 2006 11:25 am, Pavel Machek wrote:
>>>>> Could you perhaps provide list of operating points for 770? It would
>>>>> help understanding a bit, I'd say.
>>>> If there was a followup here, I missed it ...
>>>>
>>>> ISTR that it doesn't use (formal) operating points, and that a lot of =
the
>>>> basic SOC power savings (vs powering off the display or wifi) come fro=
m a
>>>> different kind of mechanism entirely.  Namely, a combination of dynamic
>>>> tick with a modified system idle task, which enters one of the OMAP low
>>>> power modes during those long periods between clock ticks or other irq=
s.
>>>>
>>>> That's one of the standard power saving schemes used on OMAP1 platforms
>>>> with Linux.
>>> sample of reasonable operating points for OMAP1 platforms along with ap=
propriate =

>>> patches may be found at http://dynamicpower.sourceforge.net/dpm-omap.ht=
ml
> =

> That's the old DPM stuff not any of the newer proposals right?
> =

> I thought the question was specifically what N770 used.
> =

> =

>> Okay... so you have system with 4 different cpu speeds. That should be
>> simple enough to get running using cpufreq, no need for complex
>> operating points patches.
> =

> And OMAP1 does have cpufreq support.  I believe that if I checked it out
> I'd find that it's used on N770, as a good way to kick in low voltage
> operation modes.
> =

> ... that's in addition to the reduced power idle, which didn't seem to
> fit into the DPM framework in any obvious way.
It fits. Omitting some details DPM allows to map/stick operating point to t=
asks. =

Mapping one of OMAP low power mode operating point to idle task does the jo=
b.

Eugeny
> =

> - Dave
> =
