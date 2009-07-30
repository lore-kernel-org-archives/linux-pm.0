From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [Bug 13865] [PATCH] hp-wmi: check that an input
	device exists	in resume handler
Date: Thu, 30 Jul 2009 13:37:11 +0100
Message-ID: <20090730123711.GB14127__45467.2139291235$1248957690$gmane$org@srcf.ucam.org>
References: <bug-13865-10028@http.bugzilla.kernel.org/>
	<200907292257.41573.rjw@sisk.pl>
	<200907301242.07973.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200907301242.07973.elendil@planet.nl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frans Pop <elendil@planet.nl>
Cc: bugzilla-daemon@bugzilla.kernel.org, LKML <linux-kernel@vger.kernel.org>, =?iso-8859-1?Q?C=E9dric?= Godin <cedric@belbone.be>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 30, 2009 at 12:42:05PM +0200, Frans Pop wrote:
> From: Frans Pop <elendil@planet.nl>
> Subject: hp-wmi: check that an input device exists in resume handler
> =

> Some systems may not support input events, or registering the input
> handler may have failed. So check that an input device exists before
> trying to set the docking and tablet mode state during resume.
> =

> Fixes: http://bugzilla.kernel.org/show_bug.cgi?id=3D13865
> =

> Reported-and-tested-by: C=E9dric Godin <cedric@belbone.be>
> Signed-off-by: Frans Pop <elendil@planet.nl>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Acked-by: Matthew Garrett <mjg@redhat.com>

-- =

Matthew Garrett | mjg59@srcf.ucam.org
