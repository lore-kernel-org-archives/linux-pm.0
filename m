From: Matthew Locke <matthew.a.locke@comcast.net>
Subject: Re: nokia 770 [was Re: community PM requirements/issues
	and PowerOP]
Date: Wed, 13 Dec 2006 14:50:12 -0800
Message-ID: <5062AF8D-E97F-41D2-8602-59578F2B4655@comcast.net>
References: <20060914101704.GA17820@elf.ucw.cz> <457FEE17.8080806@gmail.com>
	<20061213210359.GC11843@elf.ucw.cz>
	<200612131332.58606.david-b@pacbell.net>
	<BBB6202A-4F06-4D2D-BD8E-DD34267D85E9@comcast.net>
	<20061213215351.GE2418@redhat.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061213215351.GE2418@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>
Cc: linux-pm@lists.osdl.org, scott.preece@motorola.com, Pavel Machek <pavel@ucw.cz>, Amit Kucheria <amit.kucheria@nokia.com>
List-Id: linux-pm@vger.kernel.org


On Dec 13, 2006, at 1:53 PM, Dave Jones wrote:

> On Wed, Dec 13, 2006 at 01:44:02PM -0800, Matthew Locke wrote:
>
>>> I'd find that it's used on N770, as a good way to kick in low  =

>>> voltage
>>> operation modes.
>>
>> Except that cpufreq doesn't really support voltage changes
>
> The majority of cpufreq drivers in the tree right now support
> voltage scaling just fine.

Ok, let's reword my sentence.  The cpufreq interface does not support  =

voltage as a  parameter which is needed on platforms where you need  =

to do more than infer the correct voltage from the requested cpu  =

frequency.  Or something like that.  I wasn't challenging the  =

existing x86 cpufreq drivers, but the omap cpufreq driver does not  =

support voltage scaling.

>
> 		Dave
>
> -- =

> http://www.codemonkey.org.uk
