From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ioctl conversion
Date: Fri, 11 Jul 2008 11:22:30 +0200
Message-ID: <200807111122.31384.arnd__35736.659813165$1215787131$gmane$org@arndb.de>
References: <6d291e080807101728j62be7c93qba11aa214a8dfe1@mail.gmail.com>
	<200807111008.21497.arnd@arndb.de>
	<6d291e080807110121t203c7cd0v9c84fb087cd75aa0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <6d291e080807110121t203c7cd0v9c84fb087cd75aa0@mail.gmail.com>
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
To: Stoyan Gaydarov <stoyboyker@gmail.com>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 11 July 2008, Stoyan Gaydarov wrote:

> This would work normally but there are three early returns and the
> rest are just switch statements that set the return code.

I just looked at linux-next and found that Rafael has already done
the conversion from BKL to his own mutex, after Alan has introduced
the BKL in an earlier patch. Your patch is not needed any more.

It's good to look into the state of the ioctl conversion, but you
should make sure that you're not doing work that has already been
done by someone else, so try checking out linux-next first.

	Arnd <><
