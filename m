From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 1/4] Hibernate: Call platform_begin
	before	swsusp_shrink_memory
Date: Sun, 26 Oct 2008 13:00:52 +0100
Message-ID: <20081026120052.GA1607__4726.59704178131$1225022705$gmane$org@ucw.cz>
References: <200810222249.20629.rjw@sisk.pl> <200810222250.36537.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200810222250.36537.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wed 2008-10-22 22:50:35, Rafael J. Wysocki wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Hibernate: Call platform_begin before swsusp_shrink_memory
> 
> Call platform_begin() before swsusp_shrink_memory() so that we can
> always allocate enough memory to save the ACPI NVS region from
> platform_begin().
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
