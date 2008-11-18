From: Bob Copeland <me@bobcopeland.com>
Subject: Re: [PATCH] ACPI suspend: Blacklist boxes that require
	us to set SCI_EN directly on resume
Date: Tue, 18 Nov 2008 08:45:47 -0500
Message-ID: <20081118134547.GB16412@hash.localnet>
References: <200811172333.13466.rjw@sisk.pl> <49225697.90804@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49225697.90804@shaw.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Tino Keitel <tino.keitel@gmx.de>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 17, 2008 at 11:45:59PM -0600, Robert Hancock wrote:
> This is rather gross. The usual question arises, why does Windows work 
> without such a hack? Maybe there is no better solution for now, but 
> somebody should really look into why the behavior is different in Linux..

Except in this case, why does OS X work without such a hack :)

This is fallout from the acpi_enable() change for MSI netbooks IIRC,
another fixup for another broken ACPI implementation.  So it goes.

-- 
Bob Copeland %% www.bobcopeland.com
