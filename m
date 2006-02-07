From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] Complain if driver reenables interrupts
	during drivers_[suspend|resume] & re-disable
Date: Tue, 7 Feb 2006 23:59:11 +0000
Message-ID: <20060207235911.GB26558@flint.arm.linux.org.uk>
References: <200602071906.55281.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============22649047424549851=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602071906.55281.ncunningham@cyclades.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux PM <linux-pm@osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============22649047424549851==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 07, 2006 at 07:06:48PM +1000, Nigel Cunningham wrote:
> This patch is designed to help with diagnosing and fixing the cause of
> problems in suspending/resuming, due to drivers wrongly re-enabling
> interrupts in their .suspend or .resume methods. 

Sorry, aren't interrupts enabled at this point anyway?  They are if
you issue a suspend to RAM via sysfs, eg:

state_store->enter_state->suspend_prepare->device_suspend->suspend_device

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

--===============22649047424549851==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============22649047424549851==--
