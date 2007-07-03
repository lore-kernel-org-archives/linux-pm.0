From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 06:21:30 +0100
Message-ID: <20070703052130.GA17605__28488.4882312783$1183440492$gmane$org@srcf.ucam.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031454.42078.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707031454.42078.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 03, 2007 at 02:54:41PM +1000, Nigel Cunningham wrote:

> Note, though, that this won't help at all when people use the "suspend-to-ram 
> instead of powering down after writing a hibernation image" feature in 
> (uswsusp | tuxonice). Fuse is just a broken idea in the first place, but 
> given that it exists, we still need to find the underlying cause.

If / is on fuse it's unlikely that hibernation is high on your list of 
priorities right now.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
