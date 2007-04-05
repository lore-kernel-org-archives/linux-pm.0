From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 2.6.21-rc5-git 0/3] x86_pc and ACPI support
	/sys/devices/.../wakeup
Date: Fri, 6 Apr 2007 00:30:25 +0100
Message-ID: <20070405233024.GA12641@srcf.ucam.org>
References: <200704051248.40745.david-b@pacbell.net>
	<200704051620.59918.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200704051620.59918.david-b@pacbell.net>
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

On Thu, Apr 05, 2007 at 04:20:59PM -0700, David Brownell wrote:

> Same thing with S3 ... except in that case the display was trashed; I
> was able to ssh in, and switch the vt from raw console to X using the
> PS2 keyboard, but that's about it.

Excellent news. Regarding the display, you may want to give vbetool a go =

- there's nothing in Linux to reinitialise the display hardware on most =

machines, and nothing in the ACPI spec that requires the firmware to.

-- =

Matthew Garrett | mjg59@srcf.ucam.org
