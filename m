From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.31] NFS + suspend to ram hang...
Date: Thu, 24 Sep 2009 19:59:39 +0200
Message-ID: <200909241959.39497.rjw__22164.4145124175$1253815305$gmane$org@sisk.pl>
References: <6278d2220909231545x217e1100k496bbdd44d0704de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <6278d2220909231545x217e1100k496bbdd44d0704de@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 24 September 2009, Daniel J Blueman wrote:
> Without the NFS4 homedir mount, suspend to ram works perfectly. With
> NFS4 homedir, suspend is started, but doesn't complete. Invoking
> kernel crashdump, all messages and backtrace looks entirely expected
> [1].
> 
> Anyone else find the same? Expected to work or not? What information
> would help with this?

Can you try this with 2.6.30?

Best,
Rafael
