From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: x86_pc and ACPI support /sys/devices/.../wakeup
Date: Sun, 8 Apr 2007 10:56:25 -0600
Message-ID: <20070408165625.GE32713__3108.89906618304$1176051481$gmane$org@cosmic.amd.com>
References: <200704051248.40745.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704051248.40745.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 05/04/07 12:48 -0700, David Brownell wrote:
> Following are three patches for basic driver model wakeup flag support on
> PCs.  I think the first two are nearly mergable.  The third previously br=
oke
> powerpc, so it's likely not yet mergeable ... the issue was arch-specific
> differences in PCI initialization, someone else will need to solve them.
> =

> The patches are:
> =

>  - Define a platform_enable_wakeup() PM hook and use it with PCI.  (This
>    might help OLPC with its non-RTC events...)

Neat!  I'll looking forward to studying it in more detail.  I've also
forwarded this e-mail and the three patches to devel@laptop.org for their
perusual.

Jordan
