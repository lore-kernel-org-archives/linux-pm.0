From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [RFC][PATCH] PM / Platform: Remove __weak
	definitions of runtime PM callbacks
Date: Tue, 29 Mar 2011 12:13:08 +0900
Message-ID: <20110329031308.GC7338__18549.8836836361$1301368463$gmane$org@linux-sh.org>
References: <201103270058.41632.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103270058.41632.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, Mar 27, 2011 at 12:58:41AM +0100, Rafael J. Wysocki wrote:
> Remove the __weak definitions of platform bus type runtime PM
> callbacks, make platform_dev_pm_ops point to the generic routines
> as appropriate and allow architectures using platform_dev_pm_ops to
> replace the runtime PM callbacks in that structure with their own
> set.
> 
> Convert architectures providing its own definitions of the platform
> runtime PM callbacks to use the new mechanism.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Paul Mundt <lethal@linux-sh.org>
