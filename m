From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: [GIT PATCH] suspend patches for 2.6.25-rc0
Date: Thu, 7 Feb 2008 19:44:25 -0500
Message-ID: <20080208004425.GB29980__2408.48817998103$1202431568$gmane$org@cs.cmu.edu>
References: <200802011820.56693.lenb@kernel.org>
	<20080207222713.GA20549@cs.cmu.edu>
	<200802080014.41638.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802080014.41638.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 08, 2008 at 12:14:40AM +0100, Rafael J. Wysocki wrote:
> I haven't revert the changes.  It's only moved the notifier chain calls from
> the ioctls to open/release in user.c .

Ah my bad, sorry about the false alarm.

Jan
