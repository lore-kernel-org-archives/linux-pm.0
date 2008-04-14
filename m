From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 22:41:08 +0200
Message-ID: <200804142241.11545.oliver__32512.3164956041$1208205850$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0804141043001.2236-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0804141043001.2236-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Am Montag, 14. April 2008 16:49:26 schrieb Alan Stern:
> Now, I don't see what the big deal is here. =A0We all agree that it would =

> be nice and appropriate if drivers could do things like =

> request_firmware() during prepare(). =A0But for the moment they can't. =
=A0
> It's not like this is some tremendous hardship -- you aren't going to =

> have to rip out all the existing prepare() implementations and rewrite =

> them, because they don't exist yet!

True. You cannot request firmware in the current suspend() call either.
Rafael's code is a clear improvement over the existing code. Removal
of the freezer will need a lot of rewriting in any case.

	Regards
		Oliver
