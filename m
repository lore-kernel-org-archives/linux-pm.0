From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [RFC][PATCH 3/4] swsusp: Introduce restore platform
	operations
Date: Wed, 23 May 2007 00:10:20 +0400
Message-ID: <46534E2C.60808__46189.3638865606$1179864709$gmane$org@gmail.com>
References: <200705180019.35548.rjw@sisk.pl>
	<20070521233848.GN10714@elf.ucw.cz>
	<200705220155.44430.rjw@sisk.pl> <200705222203.48568.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705222203.48568.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki ?????:
> On Tuesday, 22 May 2007 01:55, Rafael J. Wysocki wrote:
> Moreover, I'm not quite certain in which points the GPEs should actually be
>   
> disabled and enabled.  For example, there are some testing data indicating that
> the enabling of GPEs should be done after all of the device drivers' .resume()
> callbacks have run.
Opposite, ACPI devices require enabled GPEs to do their resume, so 
enabling of GPEs
should happen at least before .resume() of ACPI devices is called.

Regards,
Alex.
