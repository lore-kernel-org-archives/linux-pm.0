From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REGRESSION]: hibernate/sleep regression w/ bisection
Date: Wed, 2 Nov 2011 10:08:19 -0700
Message-ID: <201111021008.19531.dmitry.torokhov@gmail.com>
References: <20111101124759.GA1326@zeus>
	<20111102163109.GA29430@core.coreip.homeip.net>
	<20111102170058.GA2388@zeus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20111102170058.GA2388@zeus>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Watts <akwatts@ymail.com>
Cc: tj@kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, November 02, 2011 10:01:00 AM Andrew Watts wrote:
> On Wed, Nov 02, 2011 at 09:31:09AM -0700, Dmitry Torokhov wrote:
> > OK, it looks like you do have input, what you do not have is X
> > functioning.
> 
> The extent of my tests on input were to notice that the LED for caps
> lock does not toggle when pressing "caps lock" after a bad resume. I
> have also tried to blindly type "reboot" and such in what should be an
> active xterm.

When in X it is X that is responsible for LED switching. Also input
processing beyond the kernel won't be happening if X is hosed.

-- 
Dmitry
