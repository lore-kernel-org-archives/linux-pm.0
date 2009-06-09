From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM:
	Rearrange core suspend code)
Date: Tue, 9 Jun 2009 16:48:09 +0200
Message-ID: <200906091648.09659.oliver__631.942557129328$1244558905$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0906091032260.28447-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906091032260.28447-100000@netrider.rowland.org>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 9. Juni 2009 16:33:12 schrieb Alan Stern:
> On Tue, 9 Jun 2009, Oliver Neukum wrote:
> > But the problem here is STR or STD. How do you notify drivers that the
> > BIOS has resumed their device instead of autoresume() being called? A
> > driver has to know that its device has become active without its
> > knowledge.
>
> That would be a wonderful contradiction in terms. =A0:-)

A practical application of the uncertainty principle in quantum computing.

But you have to notify a driver if you notice that a device's power state
has been changed without the knowledge of its driver.

	Regards
		Oliver
