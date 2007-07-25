From: Andi Kleen <ak@suse.de>
Subject: power management in alsa
Date: Wed, 25 Jul 2007 14:36:58 +0200
Message-ID: <200707251436.59156.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: tiwai@suse.de, perex@suse.cz, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


Hallo,

I noticed ALSA hda seems to only change PCI power management states
of the sound devices on suspend/resume. Is there a reason the device
cannot be automatically suspended when nobody has sound opened? 

-Andi
