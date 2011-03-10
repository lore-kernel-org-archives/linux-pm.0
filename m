From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] cpufreq: Remove the pm_message_t argument
 from driver suspend
Date: Thu, 10 Mar 2011 15:50:09 -0500
Message-ID: <20110310205008.GB7750@redhat.com>
References: <201103102113.05946.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103102113.05946.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 10, 2011 at 09:13:05PM +0100, Rafael J. Wysocki wrote:
 > From: Rafael J. Wysocki <rjw@sisk.pl>
 > 
 > None of the existing cpufreq drivers uses the second argument of
 > its .suspend() callback (which isn't useful anyway), so remove it.
 > 
 > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
 > ---
 > 
 > Hi,
 > 
 > This patch is requisite for sysdevs rework discussed here:
 > https://lkml.org/lkml/2011/3/9/439
 > Please apply or let me know if I can take it to the suspend tree.

Looks ok to me.

applied and queued for .39

thanks,

	Dave
