From: Tejun Heo <htejun@gmail.com>
Subject: Re: hibernation hangs with ATA errors (lockup_detector
	bug)
Date: Thu, 03 Jun 2010 10:17:37 +0200
Message-ID: <4C076521.8050108__35899.3911686868$1275553202$gmane$org@gmail.com>
References: <4C03C608.1040600@gmail.com> <20100601135004.GP15159@redhat.com>
	<4C051D44.7040203@gmail.com> <20100602184459.GA15159@redhat.com>
	<20100602191336.GA5164@nowhere> <20100602194336.GB5164@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100602194336.GB5164@nowhere>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Don Zickus <dzickus@redhat.com>, Jiri Slaby <jirislaby@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

Hello,

On 06/02/2010 09:43 PM, Frederic Weisbecker wrote:
> But I'm eventually surprised about this: stopping the cpu hotplug callbacks
> prevents some ATA resume callbacks to execute.
> 
> Does that mean some ata resume path are done from a cpu hotplug notifier?
> That looks weird.

libata itself doesn't use any cpu hotplug notifier.  It just uses
suspend and resume callbacks.  It looks like somehow IRQ delivery is
screwed up?

Thanks.

-- 
tejun
