From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Regression][git head f4b87dee9] ath9k doesn't work
	correctly after resume from suspend to RAM
Date: Sun, 23 May 2010 00:13:37 +0200
Message-ID: <201005230013.37578.rjw@sisk.pl>
References: <201005222353.26920.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005222353.26920.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-wireless@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@gmail.com>, "John W. Linville" <linville@tuxdriver.com>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Saturday 22 May 2010, Rafael J. Wysocki wrote:
> Hi,
> 
> With current -git on Acer Ferrari One the ath9k driver doesn't seem to work
> after resume from suspend to RAM.  NetworkManager seems to think that it works,
> but it doesn't really connect with the AP and doesn't try to obtain an IP
> address.

Sorry, this was incorrect.  It actually tries to obtain an IP address, but
fails.  Apparently, it can't obtain the address without being reloaded.

Rafael
