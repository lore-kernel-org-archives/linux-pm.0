From: David Robinson <zxvdr.au@gmail.com>
Subject: Re: 2.6.22-rc4 XFS fails after hibernate/resume
Date: Sun, 17 Jun 2007 08:29:51 +1000
Message-ID: <4674645F.5000906@gmail.com>
References: <46744065.6060605@dgreaves.com>
Reply-To: LVM general discussion and development <linux-lvm@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-lvm-bounces@redhat.com>
In-Reply-To: <46744065.6060605@dgreaves.com>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/linux-lvm>,
	<mailto:linux-lvm-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-lvm>
List-Post: <mailto:linux-lvm@redhat.com>
List-Help: <mailto:linux-lvm-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-lvm>,
	<mailto:linux-lvm-request@redhat.com?subject=subscribe>
Sender: linux-lvm-bounces@redhat.com
Errors-To: linux-lvm-bounces@redhat.com
To: LVM general discussion and development <linux-lvm@redhat.com>
Cc: linux-pm <linux-pm@lists.osdl.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
List-Id: linux-pm@vger.kernel.org

David Greaves wrote:
> This isn't a regression.
> 
> I was seeing these problems on 2.6.21 (but 22 was in -rc so I waited to 
> try it).
> I tried 2.6.22-rc4 (with Tejun's patches) to see if it had improved - no.
> 
> Note this is a different (desktop) machine to that involved my recent bugs.
> 
> The machine will work for days (continually powered up) without a 
> problem and then exhibits a filesystem failure within minutes of a resume.
> 
> I know xfs/raid are OK with hibernate. Is lvm?

I have LVM working with hibernate w/o any problems (w/ ext3). If there 
were a problem it wouldn't be with LVM but with device-mapper, and I 
doubt there's a problem with either. The stack trace shows that you're 
within XFS code (but it's likely its hibernate).

You can easily check whether its LVM/device-mapper:

1) check "dmsetup table" - it should be the same before hibernating and 
after resuming.

2) read directly from the LV - ie, "dd if=/dev/mapper/video_vg-video_lv 
of=/dev/null bs=10M count=200".

If dmsetup shows the same info and you can read directly from the LV I 
doubt it would be a LVM/device-mapper problem.

Cheers,
Dave

_______________________________________________
linux-lvm mailing list
linux-lvm@redhat.com
https://www.redhat.com/mailman/listinfo/linux-lvm
read the LVM HOW-TO at http://tldp.org/HOWTO/LVM-HOWTO/
