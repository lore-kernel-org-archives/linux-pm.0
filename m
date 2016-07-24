From: Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>
Subject: Re: [PATCH v2 00/10] Exynos IOMMU: proper runtime PM support (use
	device dependencies)
Date: Sun, 24 Jul 2016 20:02:59 +0200
Message-ID: <579502D3.7090004@math.uni-bielefeld.de>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
	<5787B2B0.9020809@math.uni-bielefeld.de>
	<5788E352.3040801@math.uni-bielefeld.de>
	<a15e438a-7fa0-3a4d-e6e2-13425512dddd@samsung.com>
	<578CB6DB.90608@math.uni-bielefeld.de>
	<6939949e-4c8e-cba0-9858-b37d1ba01869@samsung.com>
	<578D0716.6060106@math.uni-bielefeld.de>
	<7c770ff5-2b22-adf6-b8d0-e94d1d7d7550@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <7c770ff5-2b22-adf6-b8d0-e94d1d7d7550-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Marek,


Marek Szyprowski wrote:
> Hi Tobias
> 
> 
> On 2016-07-18 18:43, Tobias Jakobi wrote:
>> Marek Szyprowski wrote:
>>> On 2016-07-18 13:00, Tobias Jakobi wrote:
>>>> Marek Szyprowski wrote:
>>>>> On 2016-07-15 15:21, Tobias Jakobi wrote:
>>>>>> Tobias Jakobi wrote:
>>>>>>> Hello Marek,
>>>>>>>
>>>>>>> I've tested the patchset on 4.7-rc7 and noticed that it breaks
>>>>>>> reboot on
>>>>>>> my ODROID-X2.
>>>>>>>
>>>>>>> Going to check where exactly things break.
>>>>>> Sadly it's the last patch where everything comes together:
>>>>>> "iommu/exynos: Add proper runtime pm support"
>>>>>>
>>>>>> I still have to check if forcing runpm status to 'on' makes a
>>>>>> difference. I suspect that the aggressive clock gating might be the
>>>>>> reason?
>>>>> Thanks for testing. I will check this issue. Could you send me your
>>>>> .config?
>>>> This is the config I'm currently using:
>>>> https://github.com/tobiasjakobi/odroid-environment/blob/master/sourcecode/system/vanilla-4.7-debug.conf
>>>>
>>>>
>>>>
>>>> Do you think checking this with no_console_suspend makes sense?
>>> no_console_suspend switch won't provide more information, but I managed
>>> to reproduce your issue. I'm really confused how enabling runtime pm can
>>> cause problems with usb/smsc95xx ethernet driver (that is the reason for
>>> failed reboot). Maybe it is somehow related to the global relations
>>> between devices and drivers and the fact that creating the runtime pm
>>> links change the order of operations. I will check this again when
>>> Rafael send updated patches. Here is the log I got (after waiting some
>>> time):
>> thanks for looking into this! I'll try to reproduce this on my board. I
>> have to admit that I didn't wait too long for the hung task message to
>> appear.
>>
>> I wonder if this has something to do with regulator code cutting some
>> supplies too early. Is this on a X2 or a U2/U3?
> 
> I've reproduced it on U3.
Here's what I get on my X2.

>  * Remounting remaining filesystems read-only ...
>  *   Remounting / read only ...
> [   59.695857] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
>  [ ok ]
>  [ ok ]
> [   59.858672] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [   66.537116] smsc95xx 1-2.1.1:1.0 eth0: Failed to read reg index 0x00000114: -110
> [   66.538887] smsc95xx 1-2.1.1:1.0 eth0: Error reading MII_ACCESS
> [   66.544803] smsc95xx 1-2.1.1:1.0 eth0: MII is busy in smsc95xx_mdio_read
> [   66.551487] smsc95xx 1-2.1.1:1.0 eth0: Failed to read MII_BMSR
> [   93.597127] usb 1-2-port2: cannot reset (err = -110)
> [   94.596714] usb 1-2-port2: cannot reset (err = -110)
> [   95.596737] usb 1-2-port2: cannot reset (err = -110)
> [   96.596722] usb 1-2-port2: cannot reset (err = -110)
> [   97.596735] usb 1-2-port2: cannot reset (err = -110)
> [   97.596800] usb 1-2-port2: Cannot enable. Maybe the USB cable is bad?
> [   98.602116] usb 1-2-port2: cannot disable (err = -110)
> [   99.601744] usb 1-2-port2: cannot reset (err = -110)
> [  100.601730] usb 1-2-port2: cannot reset (err = -110)
> [  101.601743] usb 1-2-port2: cannot reset (err = -110)
> [  102.601729] usb 1-2-port2: cannot reset (err = -110)
> [  103.601746] usb 1-2-port2: cannot reset (err = -110)
> [  103.601811] usb 1-2-port2: Cannot enable. Maybe the USB cable is bad?
> [  104.606737] usb 1-2-port2: cannot disable (err = -110)
> [  105.606756] usb 1-2-port2: cannot reset (err = -110)
> [  106.606742] usb 1-2-port2: cannot reset (err = -110)
> [  107.606758] usb 1-2-port2: cannot reset (err = -110)
> [  108.606747] usb 1-2-port2: cannot reset (err = -110)
> [  109.606763] usb 1-2-port2: cannot reset (err = -110)
> [  109.606835] usb 1-2-port2: Cannot enable. Maybe the USB cable is bad?
> [  110.611748] usb 1-2-port2: cannot disable (err = -110)
> [  111.611766] usb 1-2-port2: cannot reset (err = -110)
> [  112.611758] usb 1-2-port2: cannot reset (err = -110)
> [  113.611769] usb 1-2-port2: cannot reset (err = -110)
> [  114.611758] usb 1-2-port2: cannot reset (err = -110)
> [  115.611776] usb 1-2-port2: cannot reset (err = -110)
> [  115.611846] usb 1-2-port2: Cannot enable. Maybe the USB cable is bad?
> [  116.616764] usb 1-2-port2: cannot disable (err = -110)
> [  117.617148] usb 1-2-port2: cannot disable (err = -110)
> [  122.616775] hub 1-2:1.0: hub_ext_port_status failed (err = -110)

Output stops there, I don't see any more output with respect to hung
tasks (even though hung task detection is on and I've waited for like 10
minutes).

Anyway, I looks like that smsc95xx_unbind() is never called, and hence
the check_carrier() delayed work queue isn't cancelled.

However I'm not convinced that this is the real problem. I have manually
triggered the unbind before shutdown, and while the error message from
the smsc95xx driver have disappeared, the other messages are still produced.

My guess is that we are seeing these messages because reboot is not
working, and not the other way round.


- Tobias


> 
>> I'm not sure if we
>> currently model the regulator setup correctly here (IIRC then buck8 is
>> supplying the LAN/USB block on U2/U3).
> 
> IMHO it is not really related to regulator operations, but the sequence
> of shutting down logical devices in the system. For some reasons when pm
> links
> are used, something changes the order of operations in system shutdown
> procedure, what causes smsc95xx to hang. I have no idea why, but I don't
> have
> time to investigate it further. I will wait for the next release of
> Rafael's
> pm links patches and then check everything again.
> 
> Best regards
