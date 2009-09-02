From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Subject: Re: Montreal Linux Power Management Mini-Summit, July 13,
 2009 - 	Meeting Notes
Date: Wed, 02 Sep 2009 10:36:55 +0200
Message-ID: <4A9E2EA7.8080700@st.com>
References: <alpine.LFD.2.00.0905211430220.4390@localhost.localdomain>	<alpine.LFD.2.00.0907301801240.17818@localhost.localdomain>
	<63386a3d0909011522m7a175d3eyb3bbe8a29a5fd104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <63386a3d0909011522m7a175d3eyb3bbe8a29a5fd104@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Linus
FYI:
I'm going to present a generic linux clock framework during the CELF-Europe
  @
http://www.embeddedlinuxconference.com/elc_europe09/sessions.html#Virlinzi

It's integrated in the LDM via platform_driver and platform_device.

It would be a proposal but it doesn't use the CPUFreq.

It uses struct clk to identify each phisical the clock in the system
  and it adds clock information to the platform_device to link each
  device to the clock it uses.

Regards
  Francesco

On 09/02/2009 12:22 AM, Linus Walleij wrote:
> 2009/7/31 Len Brown<lenb@kernel.org>:
>
>    
>> A Linux Power Management "mini-summit" was held on July 13th, 2009 -
>> on the first day of the Montreal Linux Symposium.
>> (...)
>>      
>    
>> SH running cpufreq on top of clock framework
>>         cpufreq has notifiers, clock framework does not
>>      
> Hm! Paul can you elaborate on what that was about.
>
> I've felt a need for clock notifiers and we've cheated by using
> CPUfreq because it so happens that the clocking in system-wide
> and whenever the CPU freq change so may the other clocks.
>
> But if I put code into a PrimeCell MMC/SPI/I2C driver or whatever and
> use CPUfreq that's very unelegant, and for other platforms where
> the CPU freq don't change when this particular device clk freq
> change plain misleading.
>
> A clk pre/postchange notifier pair would really help and would
> make for elegant drivers that can handle clock freq transitions.
>
> Has anyone poked at this?
>
> Linus Walleij
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>
>    
