From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: Alternative Concept
Date: Wed, 14 Mar 2007 13:43:08 +0300
Message-ID: <45F7D1BC.2000700@gmail.com>
References: <44ECFF94.3030506@gmail.com>	<20061007023620.GD30380@dominikbrodowski.de>	<CFF99858-3B0C-4492-807E-B61E9CA891E5@nomadgs.com>	<20070313110851.GB10702@elf.ucw.cz>	<20070313203458.GA1213@linux.intel.com>
	<484380240703131930n5e64a8fu9b935b0b513f0731@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <484380240703131930n5e64a8fu9b935b0b513f0731@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ikhwan Lee <dlrghks@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dominik Brodowski <linux@dominikbrodowski.net>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Ikhwan Lee wrote:
> Hi,
> =

> On 3/14/07, Mark Gross <mgross@linux.intel.com> wrote:
>> On Tue, Mar 13, 2007 at 12:08:51PM +0100, Pavel Machek wrote:
>>> Hi!
>>>
>>>> I believe this power parameter framework should solve many (if not
>>>> all) of the issues raised by using operating points as the base
>>>> abstraction and provide a common layer across architectures.  Eugeny
>>>> and I have the beginnings of an API proposal for this framework, but
>>>> we wanted to get some high level feedback on the concepts so we can
>>>> adjust the API if necessary.  So, comments?
>>> Looks better than powerop certainly.
> =

> I also think this power parameter framework is a lot easier to adopt.
> PowerOp ideas can be built on top of this framework later.
> =

>>> Perhaps first step would be to convert cpufreq to this new framework?
>> The first step is to get a parameter framework in upstream.
> =

> Would this involve replacing the clock framework, or are they going to co=
exist?

parameter framework would eventually replace clock framework. Separate cloc=
k and =

voltage frameworks lead to code and functionality duplication and do not ad=
dress =

such things as relationship between clocks and voltages, clock/voltage/powe=
r =

domains, etc needed for aggressive power management.

Basically a good way of thinking about parameter framework is that paramete=
r =

framework would start from existed clock framework and gradually evolve by =

addressing voltages, relationship between clocks and voltages, domains. =

Eventually clock framework functionality would be a part of power parameter =

framework.

Thanks,
Eugeny

> =

>> It will take some time for the applications of this proposed framework
>> to materialize and drive the maturing of the implementation.  These
>> won't get written unless a framework is upstream.
>>
>> I don't know if having cpufreq plug into this framework will ever make a
>> lot of sense.  However; it would be simple to create a cpufreq driver
>> that access the parameter layer for some selected platforms.  (N800?)
>>
>> --mgross
>> _______________________________________________
>> linux-pm mailing list
>> linux-pm@lists.osdl.org
>> https://lists.osdl.org/mailman/listinfo/linux-pm
>>
> =

> It seems that this power parameter framework is more toward dynamic
> (or runtime) power management of various devices on a platform. We
> should make sure it does not break (and is not broken by) system
> suspend/resume operations.
> =

> ikhwan
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
> =
