From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [BUG?] how should we handle KEY_SLEEP with
	Hibernation?
Date: Fri, 9 Oct 2009 17:22:26 +0100
Message-ID: <20091009162226.GA29435__41512.8527245999$1255105585$gmane$org@srcf.ucam.org>
References: <1255055906.5810.99.camel@falcon>
	<20091009162008.GA1092@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091009162008.GA1092@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, loongson-dev <loongson-dev@googlegroups.com>, HAL Devel <hal@lists.freedesktop.org>, liushiwei@gmail.com
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 09, 2009 at 09:20:09AM -0700, Dmitry Torokhov wrote:

> Userspace solution please. The kernel is responsible for handlig issues
> like mechanical jitter but the decision of ignoring certain key presses
> for a period of time is a policy matter and thus belongs to userspace.

Equally, I don't think it's down to hal to do anything here other than 
pass the request along. Whatever implements policy in your system 
(gnome-power-manager under gnome, for instance) should ensure it drops 
identical requests that have arrived before the previous request has 
completed.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
