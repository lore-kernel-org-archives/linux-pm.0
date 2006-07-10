From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [BUG] sleeping function called from invalid context
 during resume
Date: Mon, 10 Jul 2006 12:01:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0607101200590.7513-100000@iolanthe.rowland.org>
References: <CFF307C98FEABE47A452B27C06B85BB6ECFDB0@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ECFDB0@hdsmsx411.amr.corp.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, johnstul@us.ibm.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 10 Jul 2006, Brown, Len wrote:

> >> http://bugzilla.kernel.org/show_bug.cgi?id=3D3469
> >> =

> >> Make acpi_os_allocate() into an inline function to
> >> allow /proc/slab_allocators to work.
> >
> >Another problem with this patch; it doesn't compile.
> =

> Hmmm, to you refer to the patch on the bug-id, the one
> in e-mail, or the one checked into git?
> =

> My appologies if they don't match.  I've compiled =

> this into a few dozen kernels at this point.

I was referring to the patch in the email.

Alan Stern
