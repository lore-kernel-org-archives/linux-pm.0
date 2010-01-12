From: Deepak Sikri <deepak.sikri79@gmail.com>
Subject: Query: CPU Freq Framework
Date: Tue, 12 Jan 2010 12:14:29 +0530
Message-ID: <9841a0471001112244g24d732f7t73ec1a25d59bf430@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6417686411875600154=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: armando.visconti@st.com, shiraz.hashim@st.com
List-Id: linux-pm@vger.kernel.org

--===============6417686411875600154==
Content-Type: multipart/alternative; boundary=00504502c13b59700b047cf1fc79

--00504502c13b59700b047cf1fc79
Content-Type: text/plain; charset=ISO-8859-1

Hi,
The System timer (Clock Source & ClockEvent) for our board is sharing the
clock with CPU.On changing the CPU frequency using the CPU freq governors,
we are changing the clock being fed to CPU and timers. This is affecting the
kernel time keeping as the timer frequecy has been changed. What is the
mechanism for managing this through the CPU freq/some other Linux Framework
?

Regards
Deepak

--00504502c13b59700b047cf1fc79
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>The System timer (Clock Source &amp; ClockEvent) for our board is shar=
ing the clock with CPU.On changing the CPU frequency using the CPU freq gov=
ernors, we are changing the clock being fed to CPU and timers. This is affe=
cting the kernel time keeping as the timer frequecy has been changed. What =
is the mechanism for managing this through the CPU freq/some other Linux Fr=
amework ?</div>

<div>=A0</div>
<div>Regards</div>
<div>Deepak</div>

--00504502c13b59700b047cf1fc79--

--===============6417686411875600154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6417686411875600154==--
