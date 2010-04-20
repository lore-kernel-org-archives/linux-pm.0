From: Nick Bowler <nbowler@elliptictech.com>
Subject: Re: 2.6.34-rc5: Reported regressions from 2.6.33
Date: Tue, 20 Apr 2010 09:56:36 -0400
Message-ID: <20100420135636.GA10674__1137.54938724941$1271771910$gmane$org@elliptictech.com>
References: <deuQKFRcc0B.A.3EG.BRSzLB@tosh>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <deuQKFRcc0B.A.3EG.BRSzLB@tosh>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 05:15 Tue 20 Apr     , Rafael J. Wysocki wrote:
> If you know of any other unresolved regressions from 2.6.33, please let us
> know either and we'll add them to the list.  Also, please let us know
> if any of the entries below are invalid.

Please list these two similar regressions from 2.6.33 in the r600 DRM:

 * r600 CS checker rejects GL_DEPTH_TEST w/o depth buffer:
           https://bugs.freedesktop.org/show_bug.cgi?id=27571

 * r600 CS checker rejects narrow FBO renderbuffers:
           https://bugs.freedesktop.org/show_bug.cgi?id=27609

Thanks.

-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
