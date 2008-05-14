From: "=?ISO-8859-1?Q?Carlos_Augusto_de_Ara=FAjo_Mar?="
	<carlos.augusto.mar@gmail.com>
Subject: Re: More info about this group
Date: Wed, 14 May 2008 20:42:25 -0300
Message-ID: <eb62f8bb0805141642s506820e4jd3e569564a549031@mail.gmail.com>
References: <eb62f8bb0804281316o3f805657ucaac47bcded2e0d8@mail.gmail.com>
	<200804291635.33874.david-b@pacbell.net>
	<eb62f8bb0805050947k2f76c793id16ce29926f14b19@mail.gmail.com>
	<20080505221454.GA2087@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080505221454.GA2087@srcf.ucam.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Matthew,

answering your question:

> How is this different to the cpufreq code and governors already present
> in the Linux kernel?

The goal of our tool is to support embedded systems developers in the
translation from their code (power unware) to a power aware code. We
consider that this developers are usually not familiar with power
management and timing constraints. Our tool performs a static analysis
of the input code in order to find places where voltage and frequency
scaling code could be included. In fact, our tool also makes use of
cpufreq libs. So, our intention is not to create another cpufreq or
anything else, but to use existing tools/libs available in the open
source community.


Regards,

Carlos Mar


2008/5/5 Matthew Garrett <mjg59@srcf.ucam.org>:
> On Mon, May 05, 2008 at 12:47:23PM -0400, Carlos Augusto de Ara=FAjo Mar =
wrote:
>
>> Our group, named Group of Interest in Embedded Systems (GISE), is resear=
ching
>> about power management and other subjects related to embedded systems.
>> We began our researches last year and as a first result We developed a
>> tool for apply Dynamic Voltage and Frequency Scale (DVFS) in C codes.
>> Now, We are applying this tool in real codes and doing adjusts. This
>> tool was developed
>> under open source filosofy and will be available in sourceforge even
>> end next month (june) . The next step to be taken for us is to
>> participate of groups which interest is the same ours. In a first
>> moment, our tool was designed to work with ARM platform, more
>> specifically ARM 9.
>
> How is this different to the cpufreq code and governors already present
> in the Linux kernel?
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org
>
