From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 2/2] Freezer: Fix APM emulation breakage
Date: Thu, 22 Nov 2007 21:33:35 +0100
Message-ID: <4745E79F.50808@gmail.com>
References: <200711212322.02340.rjw@sisk.pl> <200711212326.34531.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711212326.34531.rjw@sisk.pl>
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
Cc: Nigel Cunningham <nigel@suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The APM emulation is currently broken as a result of commit
> 831441862956fffa17b9801db37e6ea1650b0f69
> "Freezer: make kernel threads nonfreezable by default"
> that removed the PF_NOFREEZE annotations from apm_ioctl() without adding
> the appropriate freezer hooks.  Fix it and remove the unnecessary variable flags
> from apm_ioctl().
> 

This patch should probably go to the 2.6.23 stable tree as
well, shouldn't it ?

		Franck
