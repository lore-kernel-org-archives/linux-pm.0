From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM:
 Rearrange core suspend code)
Date: Tue, 9 Jun 2009 10:33:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906091032260.28447-100000__17388.2934068844$1244558146$gmane$org@netrider.rowland.org>
References: <200906090925.18866.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906090925.18866.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 9 Jun 2009, Oliver Neukum wrote:

> But the problem here is STR or STD. How do you notify drivers that the BIOS
> has resumed their device instead of autoresume() being called? A driver
> has to know that its device has become active without its knowledge.

That would be a wonderful contradiction in terms.  :-)

Alan Stern
