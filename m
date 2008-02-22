From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: [Suspend-devel] 2.6.25-rc2 System no longer powers
	off after suspend-to-disk. Screen becomes green.
Date: Fri, 22 Feb 2008 08:48:26 +0800
Message-ID: <b6a2187b0802211648u2d420861v2cc4d06ba659daf2__3878.72906071625$1203967869$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802211034.22056.jesse.barnes@intel.com>
	<200802212311.44319.rjw@sisk.pl>
	<200802211545.05794.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802211545.05794.jesse.barnes@intel.com>
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
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 22, 2008 at 7:45 AM, Jesse Barnes <jesse.barnes@intel.com> wrote:
> On Thursday, February 21, 2008 2:11 pm Rafael J. Wysocki wrote:
>  > Below is a patch that should work around the issue.  Please try it and let
>  > me know if it helps.
>
>  I ended up applying the below patch instead, so it would build, and
>  unfortunately it still hung at suspend time.

I encountered the same patching problem, but realized that it was due
to earlier patch that you had wanted me to test, so if you revert your
patch back to the current git, Rafael's patch will apply and compile
cleanly.

Thanks,
Jeff.
