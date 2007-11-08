From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (2.6.25) 1/2] hibernation: clean up Kconfig
Date: Thu, 8 Nov 2007 13:29:54 +1100
Message-ID: <18226.29858.616818.855736__39394.4981428378$1194489168$gmane$org@cargo.ozlabs.ibm.com>
References: <20071107135758.100171000@sipsolutions.net>
	<20071107135848.417344000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071107135848.417344000@sipsolutions.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Johannes Berg writes:

> This cleans up the hibernation Kconfig and removes the need to
> declare centrally which architectures support hibernation. All
> architectures that currently support hibernation are modified
> accordingly.

Acked-by: Paul Mackerras <paulus@samba.org>
