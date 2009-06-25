From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: 2.6.30-rc1: touchpad disabled on hibernation
Date: Thu, 25 Jun 2009 15:37:27 +0100
Message-ID: <4A438BA7.9010800__20070.5468807884$1245940809$gmane$org@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-pm@lists.linux-foundation.org, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The synaptics touchpad on my EeePC 701 dies on hibernation.  2.6.30 was
fine, and it doesn't happen on suspend to ram either.  There are no
obvious error messages, but maybe this boot message is relevant:

Platform driver 'i8042' needs updating, please use dev_pm_ops

Alan
