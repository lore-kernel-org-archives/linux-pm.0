From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC Disable suspend on a specific device] This is a
 little	change in linux power scheme
Date: Wed, 08 Apr 2009 08:25:10 +1000
Message-ID: <1239143110.7183.56.camel@nigel-laptop>
References: <200904072257.23756.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0904071729210.307-100000@netrider.rowland.org>
	<20090407213824.GM3278@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090407213824.GM3278@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi.

On Tue, 2009-04-07 at 23:38 +0200, Pavel Machek wrote:
> Well.... userspace should not have to decide this. If userspace tells
> kernel not to suspend video card (on PC/ACPI), then we either honour
> the request, or violate ACPI spec (and probably break suspend).

What about the cases where the ACPI spec is irrelevant? (As I understand
it, not all embedded boards use ACPI). Would this be a good approach in
those cases? If so, perhaps the trick would be to make the functionality
depend on !CONFIG_ACPI?

Regards,

Nigel
