From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Fwd: [3.5-rc6+] mei: irq: request_threaded_irq is
 missing the IRQF_ONESHOT flag
Date: Fri, 13 Jul 2012 12:12:11 +0200
Message-ID: <CA+icZUXXMJ=DtPAGQHZ7MZmRWnDC2xrnQUmsOak_y_1HsmxwpA@mail.gmail.com>
References: <CA+icZUVorJNMQ3wyz8WuZop_fwwOuBo38wZg9s9RJizhM0yc-w@mail.gmail.com>
	<CA+icZUU+_PCVqWP028X7k1=Gc-EwtrXWtHyXB+EvRoofXCdmfg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+icZUU+_PCVqWP028X7k1=Gc-EwtrXWtHyXB+EvRoofXCdmfg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Is this problem MEI or PM (or even both) related?

- Sedat -

---------- Forwarded message ----------
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, Jul 13, 2012 at 12:09 PM
Subject: Re: [3.5-rc6+] mei: irq: request_threaded_irq is missing the
IRQF_ONESHOT flag
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
<gregkh@linuxfoundation.org>, Roland Dreier <roland@purestorage.com>


On Fri, Jul 13, 2012 at 11:47 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> Hi,
>
> while dealing with [1], I saw this mei-related infos in dmesg when
> doing a suspend + resume (see [1] for more logs):
>
> [17046.348467]  [<ffffffffa00554d8>] mei_pci_suspend+0x78/0xd0 [mei]
> [17047.460315] mei 0000:00:16.0: irq 47 for MSI/MSI-X
> [17047.460512] mei 0000:00:16.0: request_threaded_irq failed: irq = 47.
>
> I am not sure whom to address with the issue - so I just asked on
> #linux-rt and Thomas responded:
>
> [ 13-Jul-2012: German local-time (UTC+2) ]
> ...
> [11:03:40] <tglx> request_threaded_irq is missing the IRQF_ONESHOT flag
> ...
> [11:24:18] <tglx> anyone can fix it by sending a patch which adds the flag :)
>
> Futhermore, I found those commits, so I added folks from there to this BR:
>
> 16a50b1 mei: pci_resume: set IRQF_ONESHOT for msi request_threaded_irq
> aa189ec misc: mei: set IRQF_ONESHOT for msi request_threaded_irq
>
> If you need more infos and/or logs, please let me know.
>
> Feel free to add:
>
>      Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
>
> Kind Regards,
> - Sedat (dileks on IRC) -
>
> [1] http://marc.info/?l=linux-kernel&m=134216822724119&w=2

Here some more infos:

$ lspci -nnvv | egrep 'mei|00:16'
00:16.0 Communication controller [0780]: Intel Corporation 6
Series/C200 Series Chipset Family MEI Controller #1 [8086:1c3a] (rev
04)
        Kernel driver in use: mei

$ dmesg | egrep 'mei|00:16'
[    0.242776] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
[    0.242802] pci 0000:00:16.0: reg 10: [mem 0xf0705000-0xf070500f 64bit]
[    0.242884] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[   23.645968] mei 0000:00:16.0: setting latency timer to 64
[   23.646041] mei 0000:00:16.0: irq 47 for MSI/MSI-X
[   23.650677] mei 0000:00:16.0: wd: failed to find the client
[ 1386.959871] mei 0000:00:16.0: irq 47 for MSI/MSI-X
[ 1386.960810] mei 0000:00:16.0: wd: failed to find the client
[ 1435.138062] mei 0000:00:16.0: irq 47 for MSI/MSI-X
[ 1435.139033] mei 0000:00:16.0: wd: failed to find the client

>From the above mentionned dmesg log:

$ dmesg | egrep 'mei|00:16|IRQF_ONESHOT'
CALL-TRACE_3.5.0-rc6-1-iniza-generic_PM-related_HW-hidden.txt

[17046.348410] Modules linked in: snd_hda_codec_hdmi
snd_hda_codec_realtek rfcomm bnep parport_pc ppdev joydev
snd_hda_intel snd_hda_codec snd_hwdep snd_pcm coretemp kvm_intel
snd_page_alloc kvm arc4 snd_seq_midi snd_seq_midi_event iwlwifi i915
snd_rawmidi uvcvideo snd_seq ghash_clmulni_intel snd_seq_device
videobuf2_vmalloc aesni_intel snd_timer videobuf2_memops aes_x86_64
drm_kms_helper videobuf2_core cryptd mac80211 drm snd videodev psmouse
samsung_laptop i2c_algo_bit btusb hid_generic soundcore microcode
serio_raw cfg80211 lp mei bluetooth video mac_hid lpc_ich parport
usbhid hid r8169
[17046.348467]  [<ffffffffa00554d8>] mei_pci_suspend+0x78/0xd0 [mei]
[17047.460315] mei 0000:00:16.0: irq 47 for MSI/MSI-X
[17047.460512] mei 0000:00:16.0: request_threaded_irq failed: irq = 47.
[17047.460520] PM: Device 0000:00:16.0 failed to resume async: error -22

I am sorry if this is a different issue as already reported.

Greetings,
- Sedat -
