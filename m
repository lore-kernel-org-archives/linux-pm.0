From: Mark Oteiza <mvoteiza@udel.edu>
Subject: Re: PROBLEM: cpuidle: Quickly notice prediction failure for repeat
 mode
Date: Fri, 20 Dec 2013 17:54:45 -0500
Message-ID: <20131220225445.GA6228@holos>
References: <20131219195159.GB16912@holos>
 <52B352E3.1040903@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45]:59599 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab3LTWxs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 17:53:48 -0500
Received: by mail-qe0-f45.google.com with SMTP id 6so3000178qea.4
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2013 14:53:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52B352E3.1040903@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 19/12/13 at 09:11pm, Daniel Lezcano wrote:
> On 12/19/2013 08:51 PM, Mark Oteiza wrote:
> >Hi,
> >
> >Commit 1485191 causes a regression on my hardware (laptop) manifesting
> >itself as increased power consumption when playing music on mpd using
> >pulseaudio.
> >
> >I bisected to find 1485191.  I tested the commit it reverts (69a37bea),
> >and the commit prior 69a37bea, e34a00d6.  Here's a summary:
> >
> >   status      sha   power  coretemp
> >   ---------------------------------
> >   BAD    14851912     14W       54C
> >   GOOD   228b3023      9W       47C
> >   GOOD   69a37bea   ~8.8W       47C
> >   GOOD   e45a00d6   ~9.3W       47C
> 
> Hi Mark,
> 
> thanks for the measurements.
> 
> Is it possible you do some perf benchmarking. IIRC, this patch was reverted
> because it introduced some perf regression.
> 
>   -- Daniel

Hi,

I hope the attached perf stats are useful.

-- 
Mark Oteiza

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="perf.txt"

vim: ft=asciidoc

1. Test description
   a. Common part
   b. Varying configuration
2. Result summary
3. Raw perf stat


1. Test description

   a. Common part

All tests using `perf stat -B -p PID` and playing out the track `Boom Jinx
- Too Free To Follow (Original Mix)`. Track length 9:25 (565 seconds).

  Input #0, mp3, from '129225_Too_Free_To_Follow_Original_Mix.mp3':
    Metadata:
      encoder         : LAME v3.96.1
      artist          : Boom Jinx
      title           : Too Free To Follow (Original Mix)
      album           : Come Play Perfect / Too Free To Follow
      genre           : Progressive House
      publisher       : Anjunadeep
      track           : 2/3
      date            : 2006
      TDOR            : 2006-01-01
      TBPM            : 125
    Duration: 00:09:24.82, start: 0.000000, bitrate: 323 kb/s

The following three tests are on `3.12.5-1-ARCH`

   b. Varying configuration

The tests are done with the following `mpd.conf`:

 > # ~/.config/mpd/mpd.conf
 >
 > music_directory    "/media/music"
 > playlist_directory "~/.local/share/mpd/playlists"
 > db_file            "~/.local/share/mpd/mpd.db"
 > log_file           "~/.local/share/mpd/mpd.log"
 > pid_file           "~/.local/share/mpd/mpd.pid"
 > state_file         "~/.local/share/mpd/mpdstate"
 >
 > audio_output {
 >   type    "pulse"
 >   name    "PulseAudio"
 > }

in one of three situations/configurations:

  A. alsa only, no pulse running, audio_output block commented
  B. pulse running, audio_output block commented
  C. pulse running, audio_output block NOT commented

These three configurations are tested on the latest vanilla Arch Linux kernel
3.12.5-1-ARCH, and a patched 3.11.6-1-ARCH kernel with 1485191 reverted.


2. Result summary


On vanilla kernel `3.12.5-1-ARCH`

 Test  Cpufreq             Frontend cyc. id.  Backend cyc. id.  Percent of all branches
 --------------------------------------------------------------------------------------
 A     1.399 GHz [96.81%]  43.74% [96.86%]    11.98% [13.09%]   1.50% [96.38%]
 A     1.324 GHz [96.41%]  42.61% [96.80%]    11.76% [13.08%]   1.51% [96.94%]
 B     1.858 GHz [79.91%]  47.34% [84.83%]    37.68% [80.26%]   4.15% [65.01%]
 B     1.923 GHz [71.58%]  46.24% [90.12%]    36.23% [82.24%]   4.77% [64.75%]
 C     2.479 GHz [82.12%]  52.43% [94.14%]    39.01% [88.21%]   4.75% [41.09%]
 C     2.486 GHz [93.97%]  53.46% [94.14%]    39.26% [88.01%]   5.97% [29.84%]

On kernel `3.11.6-1-ARCH` with commit 1485191 reverted.

 Test  Cpufreq             Frontend cyc. id.  Backend cyc. id.  Percent of all branches
 --------------------------------------------------------------------------------------
 A     1.207 GHz [96.77%]  44.12% [96.74%]    11.92% [13.09%]   1.48% [96.41%]
 A     1.093 GHz [45.20%]  43.97% [96.89%]    26.83% [93.31%]   1.73% [67.77%]
 B     1.569 GHz [78.11%]  40.73% [69.44%]    36.53% [80.72%]   4.52% [80.75%]
 B     1.655 GHz [53.47%]  42.10% [82.75%]    34.82% [81.95%]   4.36% [90.81%]
 C     1.863 GHz [82.98%]  51.42% [84.33%]    37.72% [80.99%]   3.81% [67.46%]
 C     1.893 GHz [88.14%]  51.51% [70.09%]    30.86% [59.34%]   3.52% [88.33%]


3. Raw perf stat


### Test A ###
$ perf stat -B -p 5779
^C
 Performance counter stats for process id '5779':

      19269.559713 task-clock                #    0.034 CPUs utilized
            29,092 context-switches          #    0.002 M/sec
               450 cpu-migrations            #    0.023 K/sec
               780 page-faults               #    0.040 K/sec
    26,953,017,361 cycles                    #    1.399 GHz                     [96.81%]
    11,788,193,213 stalled-cycles-frontend   #   43.74% frontend cycles idle    [96.86%]
     3,229,712,476 stalled-cycles-backend    #   11.98% backend  cycles idle    [13.09%]
    12,790,505,825 instructions              #    0.47  insns per cycle
                                             #    0.92  stalled cycles per insn [83.78%]
     3,789,342,481 branches                  #  196.649 M/sec                   [96.86%]
        56,708,247 branch-misses             #    1.50% of all branches         [96.38%]

     567.364674495 seconds time elapsed


### Test B ###
$ perf stat -B -p 21640 # pulse, mpd autodetect, GOOD
^C
 Performance counter stats for process id '21640':

       5461.629046 task-clock                #    0.010 CPUs utilized
           125,451 context-switches          #    0.023 M/sec
             2,953 cpu-migrations            #    0.541 K/sec
             1,224 page-faults               #    0.224 K/sec
    10,146,727,107 cycles                    #    1.858 GHz                     [79.91%]
     4,803,761,857 stalled-cycles-frontend   #   47.34% frontend cycles idle    [84.83%]
     3,822,947,306 stalled-cycles-backend    #   37.68% backend  cycles idle    [80.26%]
    14,068,598,186 instructions              #    1.39  insns per cycle
                                             #    0.34  stalled cycles per insn [90.26%]
     1,203,848,486 branches                  #  220.419 M/sec                   [90.01%]
        49,929,970 branch-misses             #    4.15% of all branches         [65.01%]

     566.998160291 seconds time elapsed

### Test C ###
$ perf stat -B -p 22293 # pulse, pulse configured audio_device, BAD
^C
 Performance counter stats for process id '22293':

       5039.684394 task-clock                #    0.009 CPUs utilized
           201,452 context-switches          #    0.040 M/sec
             3,931 cpu-migrations            #    0.780 K/sec
             1,013 page-faults               #    0.201 K/sec
    12,491,465,987 cycles                    #    2.479 GHz                     [82.12%]
     6,549,588,957 stalled-cycles-frontend   #   52.43% frontend cycles idle    [94.14%]
     4,872,604,722 stalled-cycles-backend    #   39.01% backend  cycles idle    [88.21%]
    16,043,214,477 instructions              #    1.28  insns per cycle
                                             #    0.41  stalled cycles per insn [94.27%]
     1,432,475,493 branches                  #  284.239 M/sec                   [94.45%]
        68,002,415 branch-misses             #    4.75% of all branches         [41.09%]

     567.793946819 seconds time elapsed


### Test B ###
$ perf stat -B -p 25849 # pulse, autodetect, OK?
^C
 Performance counter stats for process id '25849':

       4828.312531 task-clock                #    0.008 CPUs utilized
            52,635 context-switches          #    0.011 M/sec
             2,920 cpu-migrations            #    0.605 K/sec
             1,060 page-faults               #    0.220 K/sec
     9,283,525,030 cycles                    #    1.923 GHz                     [71.58%]
     4,292,859,154 stalled-cycles-frontend   #   46.24% frontend cycles idle    [90.12%]
     3,363,024,956 stalled-cycles-backend    #   36.23% backend  cycles idle    [82.24%]
    13,214,633,730 instructions              #    1.42  insns per cycle
                                             #    0.32  stalled cycles per insn [91.05%]
     1,039,288,777 branches                  #  215.249 M/sec                   [91.32%]
        49,566,186 branch-misses             #    4.77% of all branches         [64.75%]

     575.362641552 seconds time elapsed

### Test C ###
# 13-18W
$ perf stat -B -p 26349 # pulse, configured audio_output. BAD
^C
 Performance counter stats for process id '26349':

       4928.812937 task-clock                #    0.009 CPUs utilized
           208,121 context-switches          #    0.042 M/sec
             4,009 cpu-migrations            #    0.813 K/sec
             1,013 page-faults               #    0.206 K/sec
    12,253,718,423 cycles                    #    2.486 GHz                     [93.97%]
     6,550,856,654 stalled-cycles-frontend   #   53.46% frontend cycles idle    [94.14%]
     4,810,974,054 stalled-cycles-backend    #   39.26% backend  cycles idle    [88.01%]
    16,108,633,255 instructions              #    1.31  insns per cycle
                                             #    0.41  stalled cycles per insn [94.10%]
     1,445,452,744 branches                  #  293.266 M/sec                   [94.04%]
        86,270,136 branch-misses             #    5.97% of all branches         [29.84%]

     568.702015081 seconds time elapsed


### Test A ###
# alsa only , no config block GOOD
$ perf stat -B -p 26696
^C
 Performance counter stats for process id '26696':

      20122.934921 task-clock                #    0.035 CPUs utilized
            29,070 context-switches          #    0.001 M/sec
               281 cpu-migrations            #    0.014 K/sec
             1,020 page-faults               #    0.051 K/sec
    26,643,218,399 cycles                    #    1.324 GHz                     [96.41%]
    11,352,679,468 stalled-cycles-frontend   #   42.61% frontend cycles idle    [96.80%]
     3,132,458,091 stalled-cycles-backend    #   11.76% backend  cycles idle    [13.08%]
    46,389,485,704 instructions              #    1.74  insns per cycle
                                             #    0.24  stalled cycles per insn [96.90%]
     3,788,903,036 branches                  #  188.288 M/sec                   [96.77%]
        57,166,014 branch-misses             #    1.51% of all branches         [96.94%]

     568.255786926 seconds time elapsed


On `3.11.6-1-ARCH` with commit 1485191 reverted.

### Test A ###
# alsa only, GOOD
$ perf stat -B -p 1260
^C
 Performance counter stats for process id '1260':

      22530.387748 task-clock                #    0.039 CPUs utilized
            29,028 context-switches          #    0.001 M/sec
               260 cpu-migrations            #    0.012 K/sec
               916 page-faults               #    0.041 K/sec
    27,183,889,434 cycles                    #    1.207 GHz                     [96.77%]
    11,992,731,634 stalled-cycles-frontend   #   44.12% frontend cycles idle    [96.74%]
     3,241,176,991 stalled-cycles-backend    #   11.92% backend  cycles idle    [13.09%]
    12,894,959,266 instructions              #    0.47  insns per cycle
                                             #    0.93  stalled cycles per insn [84.24%]
     3,793,175,080 branches                  #  168.358 M/sec                   [97.00%]
        56,150,170 branch-misses             #    1.48% of all branches         [96.41%]

     574.810366198 seconds time elapsed

### Test B ###
# pulse no config block GOOD
$ perf stat -B -p 3240
^C
 Performance counter stats for process id '3240':

       5777.516582 task-clock                #    0.010 CPUs utilized
            49,661 context-switches          #    0.009 M/sec
             2,497 cpu-migrations            #    0.432 K/sec
             1,196 page-faults               #    0.207 K/sec
     9,067,410,074 cycles                    #    1.569 GHz                     [78.11%]
     3,692,796,429 stalled-cycles-frontend   #   40.73% frontend cycles idle    [69.44%]
     3,312,214,070 stalled-cycles-backend    #   36.53% backend  cycles idle    [80.72%]
    13,213,756,363 instructions              #    1.46  insns per cycle
                                             #    0.28  stalled cycles per insn [91.14%]
     1,038,835,964 branches                  #  179.807 M/sec                   [91.00%]
        46,978,484 branch-misses             #    4.52% of all branches         [80.75%]

     598.581618771 seconds time elapsed


### Test C ###
# pulse, config block GOOD
$ perf stat -B -p 3399
^C
 Performance counter stats for process id '3399':

       6621.672200 task-clock                #    0.012 CPUs utilized
           188,868 context-switches          #    0.029 M/sec
             4,560 cpu-migrations            #    0.689 K/sec
               849 page-faults               #    0.128 K/sec
    12,337,231,455 cycles                    #    1.863 GHz                     [82.98%]
     6,343,372,974 stalled-cycles-frontend   #   51.42% frontend cycles idle    [84.33%]
     4,653,020,474 stalled-cycles-backend    #   37.72% backend  cycles idle    [80.99%]
    15,991,003,014 instructions              #    1.30  insns per cycle
                                             #    0.40  stalled cycles per insn [94.02%]
     1,482,486,392 branches                  #  223.884 M/sec                   [84.26%]
        56,429,425 branch-misses             #    3.81% of all branches         [67.46%]

     566.108971634 seconds time elapsed

### Test A ###
$ perf stat -B -p 4085
^C
 Performance counter stats for process id '4085':

      23816.993016 task-clock                #    0.042 CPUs utilized
            29,306 context-switches          #    0.001 M/sec
               230 cpu-migrations            #    0.010 K/sec
               877 page-faults               #    0.037 K/sec
    26,022,945,276 cycles                    #    1.093 GHz                     [45.20%]
    11,441,586,110 stalled-cycles-frontend   #   43.97% frontend cycles idle    [96.89%]
     6,982,409,775 stalled-cycles-backend    #   26.83% backend  cycles idle    [93.31%]
    46,405,822,403 instructions              #    1.78  insns per cycle
                                             #    0.25  stalled cycles per insn [96.50%]
     3,794,249,905 branches                  #  159.309 M/sec                   [96.84%]
        65,778,344 branch-misses             #    1.73% of all branches         [67.77%]

     568.510689271 seconds time elapsed

### Test B ###
$ perf stat -B -p 4506
^C
 Performance counter stats for process id '4506':

       5850.939684 task-clock                #    0.010 CPUs utilized
            49,814 context-switches          #    0.009 M/sec
             2,713 cpu-migrations            #    0.464 K/sec
             1,193 page-faults               #    0.204 K/sec
     9,682,944,877 cycles                    #    1.655 GHz                     [53.47%]
     4,076,656,050 stalled-cycles-frontend   #   42.10% frontend cycles idle    [82.75%]
     3,372,031,105 stalled-cycles-backend    #   34.82% backend  cycles idle    [81.95%]
    13,196,912,570 instructions              #    1.36  insns per cycle
                                             #    0.31  stalled cycles per insn [91.09%]
     1,039,765,080 branches                  #  177.709 M/sec                   [91.03%]
        45,330,554 branch-misses             #    4.36% of all branches         [90.81%]

     570.162067313 seconds time elapsed

### Test C ###
$ perf stat -B -p 4884
^C
 Performance counter stats for process id '4884':

       6505.038805 task-clock                #    0.011 CPUs utilized
           188,878 context-switches          #    0.029 M/sec
             4,786 cpu-migrations            #    0.736 K/sec
             1,018 page-faults               #    0.156 K/sec
    12,315,800,288 cycles                    #    1.893 GHz                     [88.14%]
     6,344,128,023 stalled-cycles-frontend   #   51.51% frontend cycles idle    [70.09%]
     3,800,263,568 stalled-cycles-backend    #   30.86% backend  cycles idle    [59.34%]
    15,010,836,518 instructions              #    1.22  insns per cycle
                                             #    0.42  stalled cycles per insn [91.86%]
     1,415,142,508 branches                  #  217.546 M/sec                   [94.11%]
        49,838,213 branch-misses             #    3.52% of all branches         [88.33%]

     566.421286698 seconds time elapsed

--YZ5djTAD1cGYuMQK--
