From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [RFC][PATCH 1/2] PCI PM: Introduce
 __pci_set_power_state()
Date: Mon, 23 Mar 2009 10:08:05 +1100
Message-ID: <1237763285.11186.2.camel@nigel-laptop>
References: <200903210003.55161.rjw@sisk.pl>
	<200903222208.22434.rjw@sisk.pl>  <200903222211.50930.rjw@sisk.pl>
Reply-To: nigel@tuxonice.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903222211.50930.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi.

It's not an error if we fail to set the desired state? (I see you have a
dev_warn only).

(If it is an error, the radeon_set_suspend patch needs to be adjusted to
not ignore the error code).

Regards,

Nigel
