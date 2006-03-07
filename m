From: Tehn Yit Chin <tehn-yit.chin@greyinnovation.com>
Subject: Re: apm for individual devices
Date: Tue, 07 Mar 2006 15:06:40 +1100
Message-ID: <440D06D0.2020206@greyinnovation.com>
References: <440CD773.6010401@greyinnovation.com>
	<20060307035043.GA4312@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060307035043.GA4312@neo.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Adam Belay wrote:
> On Tue, Mar 07, 2006 at 11:44:35AM +1100, Tehn Yit Chin wrote:
> 
>>Hi all,
>>
>>How does one use the sysfs entry of power/state that I can find for each 
>>registered device? Eg, for the i2c device on my s3c2410 cpu, I find the 
>>following entry,
>>
>>/sys/devices/platform/s3c2410-i2c/power/state
>>
>>I tried echoing "mem" into it, but nothing seems to happen.
>>
>>What I am looking for is a way of suspending and resuming individual 
>>devices within the PM architecture?
>>
>>Any pointers would be greatly appreciated.
>>--
> 
> 
> Out of curiousity, why do you need to suspend this individual device?
> In other words, what practical runtime power management gains would this
> sort of low level and specific power management control provide for your
> purposes?
> 
> Thanks,
> Adam
> 
> 

The example that I use is probably a bad example.

We are developing a  consumer electronic product where we need to shut 
down various devices in the product's several operating mode to maximise 
battery life. Eg: in one of its operating mode, we are not using the 
audio codec so we should suspend it to maximise battery life. There are 
also several similar scenarios where this could apply.

A better example might have been

echo -n 1 > /dev/devices/platform/product-codec/power/state

cheers,
tyc
