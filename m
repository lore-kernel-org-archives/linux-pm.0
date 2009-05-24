From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] why do we need run disk sync before entering?S3
Date: Sun, 24 May 2009 23:02:55 +0200
Message-ID: <200905242302.55640.oliver__25098.7410582185$1243199014$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org>
	<200905231105.03828.oliver@neukum.org>
	<20090523094518.GB8782@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090523094518.GB8782@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Samstag, 23. Mai 2009 11:45:18 schrieb Pavel Machek:
> suspend.sf.net, program s2both :-).

Cool. What happens if you crash after unfreezing user space but before you
declare the image invalid?

	Regards
		Oliver
