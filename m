From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Subject: Re: Info on LDM, domain system and SOCs
Date: Mon, 24 Sep 2007 11:14:26 +0000
Message-ID: <46F79C12.4010304@st.com>
References: <46DEB51F.3010000@st.com>	
	<1189430227.8343.5.camel@localhost.localdomain>	
	<46E56E81.2050105@st.com>
	<52d486620709171417o106f876dsb13ab7e4f334be48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <52d486620709171417o106f876dsb13ab7e4f334be48@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Amit Kucheria <kucheria.amit@gmail.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Amit Kucheria ha scritto:
> On 9/10/07, Francesco VIRLINZI <francesco.virlinzi@st.com> wrote:
>   
>> If you mean the <include/linux/clk.h>, I already saw it.
>> I think it's good but it isn't enough.
>> I want track also the devices on a clock to be able to notify (for each
>> device) if a clock changes.
>>     
>
> You should propose these changes to the clock framework. Designing a
> new framework is unlikely to be accepted in the kernel easily since a
> lot of platforms are using the clock framework already.
>   
Hi
I'm sorry but this is really what I don't want to do.
I think the problem is really this.

In the kernel there are a several clock struct... one for each 
architecture...

A lot of them have no relation with the linux driver model... and they 
aren't showed under /sys/...
This means there is a physical clock network not aware by the kernel.

For this reason I don't want "write-a-new" or "extend-an-existent" clock 
framework..

I'm working on a domain framework arch independent (a kind of ancestor 
of all the clock framework)
 able to track the domain relationship and also the device-on-domain 
relationship.
This framework should go under <root>/drivers/base/...
The basic idea is to create a base code for all the architectures to 
simplify (I hope)
 the clocks managements in the SOCs.

For example in my platform I can do something like:

# ls /sys/domains/pll1_clk/comms_clk/devices/
# ssc-0  ssc-1  ssc-2

This means in my platform there are
 - a parent clock pll1_clk
 - a child clock comms_clk
 - three devices (ssc-0 ssc-1 ssc-2) under comms_clk

And this information are available in user space (I think this information
 could help a power manager in user space)


Francesco
> /Amit
> --
> Amit Kucheria, Linux developer
>   
