From: Frans Pop <elendil@planet.nl>
Subject: Re: sdhci: Loads of scary messages during suspend/resume
	with SD card inserted
Date: Sun, 28 Sep 2008 22:04:07 +0200
Message-ID: <200809282204.07696.elendil__20605.2036294297$1222632403$gmane$org@planet.nl>
References: <200809282146.57960.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200809282146.57960.elendil@planet.nl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, drzeus-mmc@drzeus.cx
List-Id: linux-pm@vger.kernel.org

On Sunday 28 September 2008, Frans Pop wrote:
> Whilst playing with it, I found the following messages in my logs
> during suspend. At the time the card was inserted, but nothing on it
> was mounted.
>
> There also seems to be a problem while resuming, especially:
> mmc mmc0:8879: parent mmc0 should not be sleeping
> More context at the bottom of the mail.

Forgot the most important bits.

Kernel is current git (2.6.27-rc7-106-g6ef190c), x86_64.
Laptop is running Debian amd64/unstable.
