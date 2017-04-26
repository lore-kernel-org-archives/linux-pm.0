From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [GIT PULL] Immutable branch between MFD and IIO due for the v4.12
 merge window
Date: Wed, 26 Apr 2017 06:51:53 +0100
Message-ID: <64e7d5f8-0134-9a1c-6e2c-3e67cbafb01d@kernel.org>
References: <20170404063441.7656-1-quentin.schulz@free-electrons.com>
 <20170411100528.2zif3fyi7uoyw33n@dell>
 <0f30afec-ff42-e125-96d6-35893324f7ef@kernel.org>
 <20170424110239.cv5nylgvymhwvg4w@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170424110239.cv5nylgvymhwvg4w@dell>
Content-Language: en-GH
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: mark.rutland@arm.com, thomas.petazzoni@free-electrons.com, lars@metafoo.de, linux-pm@vger.kernel.org, liam@networkimprov.net, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, sre@kernel.org, linux-iio@vger.kernel.org, linux@armlinux.org.uk, Quentin Schulz <quentin.schulz@free-electrons.com>, wens@csie.org, robh+dt@kernel.org, icenowy@aosc.xyz, pmeerw@pmeerw.net, knaack.h@gmx.de, maxime.ripard@free-electrons.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 24/04/17 12:02, Lee Jones wrote:
> On Fri, 14 Apr 2017, Jonathan Cameron wrote:
> 
>> On 11/04/17 11:05, Lee Jones wrote:
>>> Enjoy!
>>>
>>> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
>>>
>>>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-v4.12
>>>
>>> for you to fetch changes up to f2499ab450d3052097ba53a7d763f767935c0c59:
>>>
>>>   iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs (2017-04-11 11:02:33 +0100)
>>>
>>> ----------------------------------------------------------------
>>> Immutable branch between MFD and IIO due for the v4.12 merge window
>>>
>>> ----------------------------------------------------------------
>>> Quentin Schulz (1):
>>>       iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs
>>>
>>>  drivers/iio/adc/Kconfig      |  10 +
>>>  drivers/iio/adc/Makefile     |   1 +
>>>  drivers/iio/adc/axp20x_adc.c | 617 +++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 628 insertions(+)
>>>  create mode 100644 drivers/iio/adc/axp20x_adc.c
>>>
>> Hi Lee, 
>>
>> Thanks for doing this, but the reason it was going to go through your
>> tree in the first place was a dependency on
>> commit 4707274714ef ("mfd: axp20x: Correct name of temperature data ADC registers")
>>
>> Not present in the immutable branch.
>>
>> There isn't much time for anything else going on around this driver though
>> so other than a possible merge conflict on the Kconfig and Makefile shouldn't
>> matter if this just goes through mfd. (famous last words ;)
> 
> It's not as though you committed it to text and sent it out to a
> public mailing list for us all to reference though is it?  Doh!
> 
It came up in the original discussions (which was the only reason I knew).
Chen-Yu Tsai in email:

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/495789.html

Quentin did put a link in his request that you take it, but removing the
need to click would have been better!

Jonathan
