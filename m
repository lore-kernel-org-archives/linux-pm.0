From: Andrew Watts <akwatts@ymail.com>
Subject: Re: [REGRESSION]: hibernate/sleep regression w/ bisection
Date: Wed, 2 Nov 2011 12:01:00 -0500
Message-ID: <20111102170058.GA2388__29573.355013463$1320296243$gmane$org@zeus>
References: <20111101124759.GA1326@zeus>
	<20111102054658.GA29035@core.coreip.homeip.net>
	<20111102160208.GA6657@zeus>
	<20111102163109.GA29430@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111102163109.GA29430@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: tj@kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 02, 2011 at 09:31:09AM -0700, Dmitry Torokhov wrote:
> 
> OK, it looks like you do have input, what you do not have is X
> functioning.

The extent of my tests on input were to notice that the LED for caps
lock does not toggle when pressing "caps lock" after a bad resume. I
have also tried to blindly type "reboot" and such in what should be an
active xterm.

~ Andy
