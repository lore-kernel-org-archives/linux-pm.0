From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Wed, 15 Feb 2006 12:47:29 +0000
Message-ID: <20060215124729.GA10968@srcf.ucam.org>
References: <20060208125753.GA25562@srcf.ucam.org>
	<20060210121913.GA4974@elf.ucw.cz> <43F216FE.7050101@suse.de>
	<200602142117.31232.rjw@sisk.pl> <43F3206B.6090902@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============082156322930274861=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <43F3206B.6090902@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, Stefan Seyfried <seife@suse.de>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============082156322930274861==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 15, 2006 at 01:36:59PM +0100, Thomas Renninger wrote:

> Maybe I oversaw an issue, but I really don't see a reason for connecting
> the brightness to ac in kernel space.

The backlight class maintainer specified that /sys/../brightness should 
return the *current* brightness. In some cases that's impossible without 
knowing the ac status.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

--===============082156322930274861==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============082156322930274861==--
