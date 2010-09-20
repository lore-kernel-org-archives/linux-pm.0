From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] PM / Hibernate: Default image size
	computation and comment fix
Date: Mon, 20 Sep 2010 19:04:03 +0200
Message-ID: <201009201904.03602.rjw__44639.3479862765$1285002443$gmane$org@sisk.pl>
References: <201009150021.45101.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009150021.45101.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 15, 2010, Rafael J. Wysocki wrote:
> Hi,
> 
> The following two patches fix a comment in the hibernate memory preallocation
> code and make the default image size depend on the total RAM size.  I regard
> them as 2.6.37 material.
> 
> Please let me know if there are any objections.

OK, no response means no objections to me. :-)

I'm putting the two patches in this series into suspend-2.6/linux-next.

Thanks,
Rafael
