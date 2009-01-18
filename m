From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: 2.6.29-rc2 regression: hibernation hang on eeepc-701
	(method "platform" only)
Date: Sun, 18 Jan 2009 19:19:48 +0000
Message-ID: <9b2b86520901181119kfdc15bev7f6d859172355055__26782.078392762$1232306598$gmane$org@mail.gmail.com>
References: <9b2b86520901180345j434eacbdn7386958991ee50b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9b2b86520901180345j434eacbdn7386958991ee50b@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 1/18/09, Alan Jenkins <alan-jenkins@tuffmail.co.uk> wrote:
> Hibernation hangs just after writing the image.  With s2disk I can see
> this from the console messages.  The same hang happens with kernel
> swsusp ('echo disk | sudo tee /sys/power/state'), and I can see that
> the image has been written from the HDD led.
>
> In either case, I can still hard-power-off and resume from hibernation.
>
> It doesn't hang if I use the shutdown method (either 'echo shutdown |
> sudo tee /sys/power/disk' or  's2disk -P "shutdown method=shutdown"').

As a wild guess I tried "acpi_sleep=s4_nonvs", but it didn't help.

In fact it didn't seem to work.  The kernel log says that NVS was
still saved and restored.

$ dmesg | grep -i nvs
[    0.000000]  BIOS-e820: 000000001f790000 - 000000001f7d0000 (ACPI NVS)
[    0.000000] Kernel command line: root=/dev/sda2 ro resume=/dev/sda2
resume_offset=144480 quiet acpi_sleep=s4_nonvs
[   91.105449] PM: Saving platform NVS memory
[   91.106707] PM: Restoring platform NVS memory

Thanks
Alan
