From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Resume hangs [was: mmotm 2010-12-02-16-34 uploaded]
Date: Fri, 21 Jan 2011 10:16:35 +0100
Message-ID: <4D394EF3.5000805__26182.6045382351$1295601553$gmane$org@gmail.com>
References: <201012030107.oB317ZSW019223@imap1.linux-foundation.org>
	<4D25CF4A.9090202@gmail.com> <4D38538E.9070104@gmail.com>
	<201101202202.01089.rjw@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101202202.01089.rjw@suse.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@suse.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 01/20/2011 10:02 PM, Rafael J. Wysocki wrote:
> In that case the next step would be to build the kernel with
> CONFIG_PM_ADVANCED_DEBUG set and try to switch the async flag for individual
> devices (it is located is /sys/devices/.../power/ for each device).
> 
> For example, I wonder if it is sufficient to unset it for all USB devices.

Ok, I added
for aa in /sys/bus/usb/devices/*/power/async; do
        echo disabled > $aa
done
to /etc/init.d/boot.local. Let's see :).

thanks,
-- 
js
