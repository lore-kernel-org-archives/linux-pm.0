From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Subject: Re: [linux-pm] Montreal Linux Power Management Mini-Summit, July
	13, 2009 -  Meeting Notes
Date: Thu, 03 Sep 2009 16:50:47 +0200
Message-ID: <4A9FD7C7.7070301@st.com>
References: <alpine.LFD.2.00.0905211430220.4390@localhost.localdomain>
	<alpine.LFD.2.00.0907301801240.17818@localhost.localdomain>
	<63386a3d0909011522m7a175d3eyb3bbe8a29a5fd104@mail.gmail.com>
	<4A9E2EA7.8080700@st.com>
	<20090902215832.GB21292@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20090902215832.GB21292@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Linux Power Management List <linux-pm@lists.osdl.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Russel
Sorry I don't know the clkdev API.
In any case the CF, I will present, tracks the relationship between
  device and clock.
During any clock changing the CF checks if all the device agree the new rate
  before the clock is changed.

How does the clkdev work?

Regards
  Francesco

On 09/02/2009 11:58 PM, Russell King - ARM Linux wrote:
> On Wed, Sep 02, 2009 at 10:36:55AM +0200, Francesco VIRLINZI wrote:
>    
>> Hi Linus
>> FYI:
>> I'm going to present a generic linux clock framework during the CELF-Europe
>>   @
>> http://www.embeddedlinuxconference.com/elc_europe09/sessions.html#Virlinzi
>>      
> How does this differ from the clk API with clkdev that we already have?
>
>    
