From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH 3/9] PCI: Rework pci_set_power_state
	function
Date: Tue, 24 Jun 2008 14:34:55 +0200
Message-ID: <20080624123454.GE5642__22118.6749208302$1214468847$gmane$org@ucw.cz>
References: <200806200145.33053.rjw@sisk.pl> <200806200148.24365.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200806200148.24365.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2008-06-20 01:48:23, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> PCI: Rework pci_set_power_state function
> 
> Rework pci_set_power_state() so that the platform callback is
> invoked before the native mechanism, if necessary.  Also, make
> the function check if the device is power manageable by the
> platform before invoking the platform callback.
> 
> This may matter if the device dependent on additional power
> resources controlled by the platform is being put into D0, in which
> case those power resources must be turned on before we attempt to
> handle the device itself. 
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Looks ok to me. ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
